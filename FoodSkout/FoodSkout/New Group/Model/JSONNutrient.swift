//
//  Nutrient.swift
//  FoodSkout
//
//  Created by Fernando on 11/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

struct JSONNutrient: Codable{
    var value: Double
    var attrId: Int
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case value
        case attrId = "attr_id"
        case name
    }
}
