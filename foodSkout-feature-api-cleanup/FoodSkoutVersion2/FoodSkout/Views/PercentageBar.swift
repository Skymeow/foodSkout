//
//  PercentageBar.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/25/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

/* Draws a vertical gradient percentage bar */

import Foundation
import UIKit

@IBDesignable class PercentageBar: UIView {
  
    // MARK: Class properties
    private let gLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()

    // MARK: Inspectables
    @IBInspectable var value: Float = 0.45 {
        didSet {
            drawPath()
        }
    }
  
    // MARK: Class Methods
    func drawPath() {
        shapeLayer.strokeEnd = CGFloat(value)
    }
    
    // MARK: Setup
    func setup() {
        setupLine()
        setupGradient()
    }
    
    func setupLine() {
        // Setup shape layer options
        layer.addSublayer(shapeLayer)
        shapeLayer.strokeStart = 0
        shapeLayer.lineWidth = self.frame.size.width
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineDashPattern = [8, 7]
        let path = UIBezierPath()
        let w = self.frame.size.width
        let h = self.frame.size.height
        // path is invisible
        
        // Draw path from center bottom to center top
        path.move(to: CGPoint(x: w * 0.5, y: h))
        path.addLine(to: CGPoint(x: w * 0.5, y: 0))
        shapeLayer.path = path.cgPath
        
        drawPath()
    }
    
    func setupGradient() {
        // add gradient layer as sub view
        // size gradient to size of view
        // define start and end colors
        // set colors for gradient
        // since (0,1) is upper left, (1,1) is lower right,
        // (startX: 0.5, startY: 1), (endX: 0.5, endY: 0)
        // Set shape layer as mask for gradient layer
        
         layer.addSublayer(gLayer)
         gLayer.frame = bounds
         let bottom = UIColor(red: 0.9569, green: 0.2627, blue: 0.2118, alpha: 0.4).cgColor
         let top = UIColor(red: 0.9451, green: 0.1412, blue: 0.4196, alpha: 1.0).cgColor
         gLayer.colors = [bottom, top]
         gLayer.startPoint = CGPoint(x: 0.5, y: 1)
         gLayer.endPoint = CGPoint(x: 0.5, y: 0)
         gLayer.mask = shapeLayer
    }
    
    // MARK: Lifecycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // layoutSubviews allow view to be drew in storyBoard
    override func layoutSubviews() {
        setup()
    }
}
