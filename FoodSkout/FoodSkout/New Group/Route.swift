//
//  Route.swift
//  FoodSkout
//
//  Created by Fernando on 12/2/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation


/// An enumeration for the Routes bein used in the Networking Class
///
/// - organs: route to get organs from our API
/// - foods: route to get foods from nutritionix API
/// - foodImg: route to get the foods images from pixabay API
/// - paramForNutrients: route to get the foods images from edamam API
/// - getNutrientsLabel: route to get the foods images from edamam API
enum Route {
    case organs(organName: String)
    case foods
    case foodImg(foodImgQuery: String)
    case paramForNutrients(ingr: String)
    case getNutrientsLabel
    
    
    /// Get the path to append to the base url of the respective route
    ///
    /// - Returns: string for route
    func path() -> String {
        switch self {
        case .organs:
            return "organs"
        case .foods:
            return "foods"
        case .foodImg:
            return ""
        case .paramForNutrients:
            return "parser"
        case .getNutrientsLabel:
            return "nutrients"
        }
    }
    
    
    /// Generate URL parameters for the respective route
    ///
    /// - Returns: A dictionary containing the necessary url parameters
    func urlParameters() -> [String: String] {
        switch self {
        case let .organs(organName):
            return ["organ_name": organName]
        case .foods:
            return [:]
        case let .foodImg(foodImgQuery):
            return ["key": "7246347-e95eeb596160c710188dfa4ff",
                    "q": foodImgQuery,
                    "image_type": "photo",
                    "category": "food"]
        case let .paramForNutrients(ingr):
            return ["app_id": "338dc80d",
                    "appp_key": "8af485e0c5915a60459b01f079a95863",
                    "ingr": ingr]
        case .getNutrientsLabel:
            return ["app_id": "338dc80d",
                    "appp_key": "8af485e0c5915a60459b01f079a95863"]
        }
    }
    
    
    /// Get the base url for the respective route
    ///
    /// - Returns: the base url in string format
    func baseURl() -> String {
        switch self {
        case .organs:
            return "http://127.0.0.1:5000/"
        case .foods:
            return ""
        case .foodImg:
            return "https://pixabay.com/api/"
        case .paramForNutrients:
            return "https://api.edamam.com/api/food-database/"
        case .getNutrientsLabel:
            return "https://api.edamam.com/api/food-database/"
        }
    }
    
    
    /// Generate JSON body for post requests in the respective route
    ///
    /// - Parameter data: an Encodable object
    /// - Returns: An encoded object
    func body(data:Encodable) -> Data? {
        switch self {
        case .organs, .foods, .foodImg, .paramForNutrients:
            return nil
        case .getNutrientsLabel:
            guard let ingredientBody = data as? IngredientBody else { return nil}
            let result = try? JSONEncoder().encode(ingredientBody)
            return result
            
        }
    }
}
