//
//  Card.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Card: Codable {
    var _id: String
    var idName: String
    var rarity: String
    var type: String
    var name: String
    var description: String
    var elixirCost: Int
    var copyId: Int
    var arena: Int
    var order: Int
    var __v: Int

    public init(_id: String, idName: String, rarity: String, type: String, name: String, description: String, elixirCost: Int, copyId: Int, arena: Int, order: Int, __v: Int) {
        self._id = _id
        self.idName = idName
        self.rarity = rarity
        self.type = type
        self.name = name
        self.description = description
        self.elixirCost = elixirCost
        self.copyId = copyId
        self.arena = arena
        self.order = order
        self.__v = __v
    }
    
    static func buildCard(json: JSON) -> Card? {
        if let _id = json["_id"].string,
            let type = json["type"].string,
            let name = json["name"].string,
            let idName = json["idName"].string,
            let description = json["description"].string {
            
            //Optional, since they are not needed
            let rarity = json["rarity"].string ?? ""
            let elixirCost = json["elixirCost"].int ?? 0
            let copyId = json["copyId"].int ?? 0
            let arena = json["arena"].int ?? 0
            let order = json["order"].int ?? 0
            let __v = json["__v"].int ?? 0
            
            return Card(_id: _id, idName: idName, rarity: rarity, type: type, name: name, description: description, elixirCost: elixirCost, copyId: copyId, arena: arena, order: order, __v: __v)
        }else{
            return nil
        }
    }
}

