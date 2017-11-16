//
//  Food.swift
//  FoodSkout
//
//  Created by Fernando on 11/13/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

struct Foods: Codable {
    var branded: [Food]
    var common: [Food]
}

struct Food: Codable {
    var food_name: String
    var full_nutrients: [Nutrient]?
}
