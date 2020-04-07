//
//  ViewController.swift
//  TriangleGame
//
//  Created by Anastasia Reyngardt on 07.04.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        timeLabel.text = "Время: \(sender.value) сек"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

