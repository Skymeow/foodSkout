//
//  Food.swift
//  FoodSkout
//
//  Created by Fernando on 11/13/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

struct JSONFoods: Codable {
    var branded: [JSONFood]
    var common: [JSONFood]
}

struct JSONFood: Codable {
    var foodName: String
    var fullNutrients: [JSONNutrient]?
    
    enum CodingKeys: String, CodingKey {
        case foodName = "food_name"
        case fullNutrients = "full_nutrients"
    }
    
}
