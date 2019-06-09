//
//  Card.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit

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
}

