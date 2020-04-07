//
//  ViewController.swift
//  TriangleGame
//
//  Created by Anastasia Reyngardt on 07.04.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!
    
    //MARK: - Properties
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    
    //MARK: - IBAction
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }
    
    @IBAction func actionButtonTaped(_ sender: UIButton) {
        if isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    //MARK: - Metods
    private func startGame() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(gameTimerTick),
            userInfo: nil,
            repeats: true)
        gameTimeLeft = stepper.value
        isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        isGameActive = false
        updateUI()
        gameTimer?.invalidate()
    }
    
    private func updateUI() {
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timeLabel.text = "Осталось: \(Int(gameTimeLeft)) сек"
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            timeLabel.text = "Время: \(Int(stepper.value)) сек"
            actionButton.setTitle("Начать", for: .normal)
        }
    }
    
    @objc private func gameTimerTick() {
        gameTimeLeft -= 1
        if gameTimeLeft == 0 {
            stopGame()
        } else {
            updateUI()
        }
        
    }
    
        //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
    }


}

