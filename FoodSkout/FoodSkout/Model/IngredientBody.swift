//
//  Ingredient.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/2/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct IngredientBody: Encodable {
    var yield: Int
    var ingredients: [Ingredient]
    
    init(yield: Int, ingredients: [Ingredient]) {
        self.yield = yield
        self.ingredients = ingredients
    }
}

struct Ingredient: Encodable {
    var quantity: Int
    var measureURI: String
    var foodURI: String
    
    init(quantity: Int, measureURI: String, foodURI: String) {
        self.quantity = quantity
        self.measureURI = measureURI
        self.foodURI = foodURI
    }
}

