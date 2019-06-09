//
//  CardTableViewCell.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCard(card: Card){
        cardType.text = card.type
        cardName.text = card.name
    }
}

