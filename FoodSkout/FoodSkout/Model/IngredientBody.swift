//
//  Ingredient.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/2/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct IngredientBody: Codable {
    var yield: Int
    var ingredients: [Ingredient]
    
    init(yield: Int, ingredients: [Ingredient]) {
        self.yield = yield
        self.ingredients = ingredients
    }
}

struct Ingredient: Codable {
    var quantity: Int
    var measureURI: String
    var foodURI: String
    
    init(quantity: Int, measureURI: String, foodURI: String) {
        self.quantity = quantity
        self.measureURI = measureURI
        self.foodURI = foodURI
    }
}

struct IngredientResult {
//    var dietLabels: [String]
    var healthLabels: [String]
    
    enum Keys: String, CodingKey {
        case healthLabels
    }
}

extension IngredientResult: Decodable {
    init(with decoder: Decoder) {
        let container = try? decoder.container(keyedBy: Keys.self)
        let healthLabels = try? container?.decode(String.self, forKey: .healthLabels)
        let utf8Data = healthLabels??.data(using: String.Encoding.utf8)
        let utf8 = String.init(data: utf8Data!, encoding: String.Encoding.utf8)
        
        self.init(healthLabels: utf8)
    }
}
struct Params: Decodable {
    var parsed: [ParamsLayer]
}

struct ParamsLayer: Decodable {
    var food: FoodObj
}

struct FoodObj: Decodable {
    var uri: String
}


