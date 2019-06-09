//
//  CardDetailTableViewCell.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit
import SDWebImage

class CardDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardDescription: UILabel!
    @IBOutlet weak var cardElixirCost: UILabel!
    @IBOutlet weak var elixirView: UIView!
    @IBOutlet weak var rarityView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCard(card: Card){
        cardType.text = card.type
        cardName.text = card.name
        cardDescription.text = card.description
        cardElixirCost.text = "\(card.elixirCost)"
        
        let url  = ApiHandler().serverURL + ServerMethods.GetImage.rawValue + card.idName + ".png"
        cardImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: getDefaultProfilePictureName()))
        
        if let rarity = RarityEnum(rawValue: card.rarity) {
            switch rarity {
            case .Common:
                rarityView.backgroundColor = .white
            case .Rare:
                rarityView.backgroundColor = .orange
            case .Epic:
                rarityView.backgroundColor = .purple
            case .Legendary:
                rarityView.backgroundColor = .cyan
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        elixirView.layer.cornerRadius = elixirView.frame.height / 2
        
        rarityView.layer.cornerRadius = rarityView.frame.height / 2
        rarityView.layer.borderWidth = 1
        rarityView.layer.borderColor = UIColor.black.cgColor
    }
    
    //Function to return the default image
    func getDefaultProfilePictureName() -> String {
        return "ClashRoyaleLogo"
    }
}

//Enum for card rarity
enum RarityEnum: String {
    case Common = "Common"
    case Rare = "Rare"
    case Epic = "Epic"
    case Legendary = "Legendary"
}
