//
//  ViewController.swift
//  Lab1
//
//  Created by Michael Sun on 9/13/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        card.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2



        // Do any additional setup after loading the view.
    }
    @IBAction func didtapFlashcard(_ sender: Any) {
        if frontLabel.isHidden == true {
            frontLabel.isHidden = false
        }
        else{ frontLabel.isHidden = true
        }
    }
    
}

