//
//  ViewController.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
    }
    
    func initButton(){
        enterButton.layer.cornerRadius = 10
    }
}

