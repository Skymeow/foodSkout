//
//  Food.swift
//  FoodSkout
//
//  Created by Fernando on 11/13/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

struct Food: Codable {
    var food_name: String
    var full_nutrients: [Nutrient]?
}
