//
//  Networking.swift
//  FoodSkout
//
//  Created by Fernando on 11/13/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

enum Route {
    case food
    case nutrients
    
    // Path
    func path() -> String {
        switch self {
        case .food:
            return "users"
        case .nutrients:
            return "trips"
        }
    }
    
    // URL Parameters - query
    func urlParameters() -> [String: String] {
        switch self {
        case .food:
            return [:]
        case .nutrients:
            return [:]
        }
    }
    
    // Body
//    func body(data: Encodable?) -> Data? {
//        let encoder = JSONEncoder()
//        switch self {
//        case .user:
//            guard let model = data as? User else {return nil}
//            let result = try? encoder.encode(model)
//            return result
//        case .trips:
//            guard let model = data as? Trip else {return nil}
//            let result = try? encoder.encode(model)
//            return result
//        }
//    }
}


class Networking {
    static let instance = Networking()
    
//    let baseUrlString = "https://calm-hamlet-30270.herokuapp.com/"
    let session = URLSession.shared
    
    func fetch(route: Route, method: String, headers: [String: String], data: Encodable?, completion: @escaping (Data) -> Void) {
        
        let fullUrlString = "https://trackapi.nutritionix.com/v2/search/instant?query=bananas&detailed=true"
        
        let url = URL(string: fullUrlString)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["x-app-id": "7368555a", "x-app-key": "6617373d858215db52d88de41715d6c6"]
        request.httpMethod = "GET"
        //        request. = ["query": "organifi"]
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            completion(data)
        }.resume()

        
    }
}





