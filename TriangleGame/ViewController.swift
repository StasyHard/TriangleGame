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
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameFieldView: GameFieldView!
    
    //MARK: - Properties
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    private var timer: Timer?
    private var displayDuration: TimeInterval = 2
    private var score = 0
    
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
    
    func objectTaped() {
        guard isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    //MARK: - Metods
    private func startGame() {
        score = 0
        repositionImageWithTimer()
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
        timer?.invalidate()
        gameTimer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    
    private func updateUI() {
        gameFieldView.isShapeHiden = !isGameActive
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
    
     @objc private func moveImage() {
        gameFieldView.randomizeShapes()
    }
    
    private func repositionImageWithTimer() {
        timer?.invalidate()
               timer = Timer.scheduledTimer(
                   timeInterval: displayDuration,
                   target: self,
                   selector: #selector(moveImage),
                   userInfo: nil,
                   repeats: true)
               timer?.fire()
    }
    
        //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        
        updateUI()
        
        gameFieldView.shapeHitHadler = { [weak self] in
            self?.objectTaped()
        }
    }


}

