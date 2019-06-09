//
//  CardTableViewCell.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit
import SDWebImage

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
        
        let url  = ApiHandler().serverURL + ServerMethods.GetImage.rawValue + card.idName + ".png"
        
        cardImage.sd_setShowActivityIndicatorView(true)
        cardImage.sd_setIndicatorStyle(.gray)
        cardImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: getDefaultProfilePictureName()))
    }
    
    //Function to return the default image
    func getDefaultProfilePictureName() -> String {
        return "ClashRoyaleLogo"
    }
}

