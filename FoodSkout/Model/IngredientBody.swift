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

struct IngredientResult: Decodable {
    let healthLabels: [String]
//    let totalNutrients: Mineral
    let totalDaily: [String:Nutrient]
}

//struct Mineral: Decodable {
//    let SUGAR: Sugar?
//    let FAT: Fa?
//    let PROCNT: Pr?
//}
//
//struct Sugar: Decodable {
//    let quantity: Float
//    let unit: String
//}
//
//struct Fa: Decodable {
//    let quantity: Float
//    let unit: String
//}
//
//struct Pr: Decodable {
//    let quantity: Float
//    let unit: String
//}

struct Params: Decodable {
    var hints: [ParamsLayer]
}

struct ParamsLayer: Decodable {
    var food: FoodObj
}

struct FoodObj: Decodable {
    var uri: String
}


