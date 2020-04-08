//
//  GameControlView.swift
//  TriangleGame
//
//  Created by Anastasia Reyngardt on 08.04.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit
@IBDesignable

class GameControlView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!
    
    //MARK: - Properties
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet { updateUI() }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet { updateUI() }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        } set {
            stepper.value = newValue
            updateUI()
        }
    }
    var startStopHandler: (() -> Void )?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - IBAction
    @IBAction func stepperChange(_ sender: UIStepper) {
        updateUI()
    }
    
    @IBAction func actionButtonTaped(_ sender: UIButton) {
        startStopHandler?()
    }
    
    //MARK: - Metods
    private func setup() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
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
    

}
