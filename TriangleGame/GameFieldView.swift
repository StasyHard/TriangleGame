//
//  GameFieldView.swift
//  TriangleGame
//
//  Created by Anastasia Reyngardt on 08.04.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit
@IBDesignable

class GameFieldView: UIView {
    
    //MARK: - Properties
    @IBInspectable var shapeColor: UIColor = .red {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable var shapePosition: CGPoint = .zero {
    didSet { setNeedsDisplay() }
    }
    @IBInspectable var shapeSize: CGSize = CGSize(width: 40, height: 40) {
    didSet { setNeedsDisplay() }
    }
    @IBInspectable var isShapeHiden: Bool = false {
    didSet { setNeedsDisplay() }
    }
    
    var shapeHitHadler: (() -> Void)?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard !isShapeHiden else {
            curPath = nil
            return
        }
        shapeColor.setFill()
        let path = getTrianglePath(in: CGRect(origin: shapePosition, size: shapeSize))
        path.fill()
        curPath = path
    }
    
    //MARK: - Metods
    func randomizeShapes() {
        let maxX = bounds.maxX - shapeSize.width
        let maxY = bounds.maxY - shapeSize.height
        let x = CGFloat(arc4random_uniform(UInt32(maxX)))
        let y = CGFloat(arc4random_uniform(UInt32(maxY)))
        shapePosition = CGPoint(x: x, y: y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let curPath = curPath else { return }
        let hit = touches.contains { touch -> Bool in
            let touchPoint = touch.location(in: self)
            return curPath.contains(touchPoint)
        }
        if hit {
            shapeHitHadler?()
        }
    }
    
    private var curPath: UIBezierPath?
    
    private func getTrianglePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 0
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.close()
        path.stroke()
        path.fill()
        return path
    }
    
    
}
