//
//  ScrollViewOverlay.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class TriangleView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    isOpaque = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var color = UIColor.blue {
    didSet {
      setNeedsDisplay()
    }
  }
  var frameToFill: CGRect? {
    didSet {
      setNeedsLayout()
    }
  }
  
  override func draw(_ rect: CGRect) {
    UIColor.clear.setFill()
    let frame = frameToFill ?? layer.frame
    UIBezierPath(rect: frame).fill()
    color.setFill()
    
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 0, y: 0))
    bezierPath.addLine(to: CGPoint(x: frame.width, y: 0))
    bezierPath.addLine(to: CGPoint(x: frame.width / 2, y: frame.height))
    bezierPath.addLine(to: CGPoint(x: 0, y: 0))
    bezierPath.close()
    bezierPath.fill()
  }
}
