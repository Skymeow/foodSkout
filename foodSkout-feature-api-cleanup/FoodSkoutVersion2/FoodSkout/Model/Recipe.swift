//
//  Recipe.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/11/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    var hits: [Recipes]
}

struct Recipes: Codable {
    var recipe: RecipeDetail
}

struct RecipeDetail: Codable {
    var label: String
    var image: String
    var ingredientLines: [String]
    var calories: Double
    var totalWeight: Double
    var healthLabels: [String]
}
