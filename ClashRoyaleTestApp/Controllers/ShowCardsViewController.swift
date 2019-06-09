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
    
    var cards: [Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ShowCardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardTableViewCell", for: indexPath) as! CardTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

