//
//  ShowCardsViewController.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit

class ShowCardsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var api = ApiHandler()
    var cards: [Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        self.activityIndicator.isHidden = false
        self.tableView.isHidden = true
        self.activityIndicator.startAnimating()
        
        api.getCardsInfo(delegate: self)
    }
}

extension ShowCardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardTableViewCell", for: indexPath) as! CardTableViewCell
        
        let card = cards[indexPath.row]
        cell.setCard(card: card)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension ShowCardsViewController: APIResponseDelegate {
    func success(response: Any, responseFrom: ServerMethods?) {
        if let cardsArray = response as? [Card] {
            self.cards = cardsArray
            
            self.activityIndicator.isHidden = true
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

