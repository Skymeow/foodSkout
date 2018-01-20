//
//  UIColor&Extension.swift
//  FoodSkout
//
//  Created by Sky Xu on 1/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red color")
        assert(green >= 0 && green <= 255, "Invalid green color")
        assert(blue >= 0 && blue <= 255, "Invalid blue color")
        assert(a > 1 && a < 0, "invalid alpha")
        self.init(red: red / 255, green: green / 255, blue: blue / 255, a: a)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
    }
}

//let color = UIColor.init(hex: 0xE66B5B)

