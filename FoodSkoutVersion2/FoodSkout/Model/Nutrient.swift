//
//  Nutrient.swift
//  FoodSkout
//
//  Created by Fernando on 11/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

struct Nutrient: Codable{
    var label: String
    var quantity: Float
    var unit: String
}

extension Nutrient: Comparable {
    static func == (lhs: Nutrient, rhs: Nutrient) -> Bool {
        return lhs.label == rhs.label &&
            lhs.quantity == rhs.quantity &&
            lhs.unit == rhs.unit
    }
    
    static func < (lhs: Nutrient, rhs: Nutrient) -> Bool {
        return lhs.quantity < rhs.quantity
    }
    
    static func > (lhs: Nutrient, rhs: Nutrient) -> Bool {
        return lhs.quantity > rhs.quantity
    }
}
