//
//  NetWorking.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/23/17.//  Copyaright © 2017 Sky Xu. All rights reserved.
//

import Foundation

enum Route {
    case organs(organName: String)
    case foods
    case foodImg(foodImgQuery: String)
    case paramForNutrients(ingr: String)
    case getNutrientsLabel
    case recipe(foodName: String)
    
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
        case .recipe:
            return "search"
        default:
            return ""
        }
    }
    
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
            return [
                "app_id": "338dc80d",
                "app_key": "8af485e0c5915a60459b01f079a95863",
                "ingr": ingr,
            ]
        case .getNutrientsLabel:
            return ["app_id": "338dc80d",
                    "app_key": "8af485e0c5915a60459b01f079a95863",]
        case let .recipe(foodName):
            return [
                "app_id": "f5a7c7a3",
                "app_key": "446accd73b9b96d52f80edd750adcdfb",
                "q": foodName,
            ]
        default:
            return [:]
        }
    }
    
    func baseURl() -> String {
        switch self {
        case .organs:
            return "https://foodskout.herokuapp.com/"
        case .foods:
            return ""
        case .foodImg:
            return "https://pixabay.com/api/"
        case .paramForNutrients:
            return "https://api.edamam.com/api/food-database/"
        case .getNutrientsLabel:
            return "https://api.edamam.com/api/food-database/"
        case .recipe:
            return "https://api.edamam.com/"
        default:
            return ""
        }
    }
    
    func body(data:Encodable) -> Data? {
        switch self {
        case .organs:
            return nil
        case .foods:
            return nil
        case .foodImg:
            return nil
        case .paramForNutrients:
            return nil
        case let .getNutrientsLabel:
            let encoder = JSONEncoder()
            guard let ingredientBody = data as? IngredientBody else { return nil}
            let result = try? encoder.encode(ingredientBody)
            return result
        case .recipe:
            return nil
        default:
            return nil
        }
    }
}
class Networking {
    static let instance = Networking()
    let session = URLSession.shared
    
    func fetch(route: Route, method: String, data: Encodable?, completion: @escaping (Data, Int) -> Void) {
        var baseURL = route.baseURl()
        let urlString = baseURL.appending(route.path())
        var toURL = URL(string: urlString)!
        toURL = toURL.appendingQueryParameters(_parametersDictionary: route.urlParameters())
        var request = URLRequest(url: toURL)
        request.httpBody = route.body(data: data)
        request.httpMethod = method
        if request.httpMethod == "POST"
        {
            request.setValue(" application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyRequest = request.httpBody
            let resultReq = try? JSONSerialization.jsonObject(with: bodyRequest!, options: .allowFragments)
        }
        
        session.dataTask(with: request) { (data, response, error) in
       
            guard let responseCode = response as? HTTPURLResponse else {return}
            let statusCode = responseCode.statusCode
            guard let data = data else { return }
            let str = String.init(data: data, encoding: String.Encoding.isoLatin1)
            let newData = str?.data(using: String.Encoding.utf8)
            
            completion(newData!, statusCode)
            }.resume()
    }
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@", String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

extension URL {
    func appendingQueryParameters(_parametersDictionary: Dictionary<String, String>) -> URL {
        let URLString: String = String(format: "%@?%@", self.absoluteString, _parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}


