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
    @IBOutlet weak var gameControl: GameControlView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameFieldView: GameFieldView!
    
    //MARK: - Properties
    private var gameTimer: Timer?
    private var timer: Timer?
    private var displayDuration: TimeInterval = 2
    private var score = 0
    
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
        gameControl.startStopHandler = { [weak self] in
            self?.actionButtonTaped()
        }
        gameControl.gameDuration = 20
    }
    
    //MARK: - IBAction
    func objectTaped() {
        guard gameControl.isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    func actionButtonTaped() {
        if gameControl.isGameActive {
            stopGame()
        } else {
            startGame()
        }
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
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        gameControl.isGameActive = false
        updateUI()
        timer?.invalidate()
        gameTimer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    
    private func updateUI() {
        gameFieldView.isShapeHiden = !gameControl.isGameActive
    }
    
    @objc private func gameTimerTick() {
        gameControl.gameTimeLeft -= 1
        if gameControl.gameTimeLeft == 0 {
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

}

