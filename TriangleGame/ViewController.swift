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
    @IBOutlet weak var gameFieldView: UIView!
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        timeLabel.text = "Время: \(sender.value) сек"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
    }


}

