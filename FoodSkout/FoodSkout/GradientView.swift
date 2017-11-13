//
//  GradientView.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.white {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.black {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var angle: CGFloat = 90 {
        didSet {
            layoutSubviews()
        }
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        let colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.colors = colors
        
        let radians = angle * CGFloat(Double.pi) / 180
        
        let x1 = cos(radians) * 0.5 + 0.5
        let x2 = 1 - x1
        let y1 = sin(radians) * 0.5 + 0.5
        let y2 = 1 - y1 + 0.2
        
        gradientLayer.endPoint = CGPoint(x: x1, y: y1)
        gradientLayer.startPoint = CGPoint(x: x2, y: y2)
        
        self.setNeedsDisplay()
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
