//
//  PercentageBar.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/25/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class PercentageBar: UIView {
  
  private let gLayer = CAGradientLayer()
  private let shapeLayer = CAShapeLayer()
  
  var value: Float = 0.45 {
    didSet {
      drawPath()
    }
  }
  
  func drawPath() {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: self.frame.origin.x, y: self.frame.size.width * CGFloat(value)))
    shapeLayer.path = path.cgPath
    shapeLayer.strokeEnd = CGFloat(value)
  }
    
  func setup() {
    layer.addSublayer(shapeLayer)
    shapeLayer.lineWidth = self.frame.size.width
    shapeLayer.strokeColor = UIColor.blue.cgColor
    shapeLayer.fillColor = UIColor.red.cgColor
    shapeLayer.lineDashPattern = [4, 2]
    }
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
//    layer.addSublayer(gLayer)
//    gLayer.frame = bounds
//    let red = UIColor.red.cgColor
//    let yellow = UIColor.yellow.cgColor
//    gLayer.colors = [red, yellow]
//    gLayer.startPoint = CGPoint(x: 0, y: 0)
//    gLayer.endPoint = CGPoint(x: 0, y: self.frame.size.width)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
    
//    layoutSubviews allow view to be drew in storyBoard
    override func layoutSubviews() {
        setup()
    }
}
