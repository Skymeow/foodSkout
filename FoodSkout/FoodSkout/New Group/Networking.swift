//
//  NetWorking.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation


/// Abstraction of the networking layer
class Networking {
    static let instance = Networking()
    let session = URLSession.shared
    
  func path() -> String {
    switch self {
    case .organs:
      return "organs"
    case .foods:
      return "foods"
    case .foodImg:
        return ""
    case let .paramForNutrients(ingr):
        return "parser?app_key=8af485e0c5915a60459b01f079a95863&app_id=338dc80d&ingr=\(ingr)"
    case .getNutrientsLabel:
        return "nutrients"
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
    case .paramForNutrients:
        return [:]
    case .getNutrientsLabel:
        return ["app_id": "338dc80d",
                "app_key": "8af485e0c5915a60459b01f079a95863"]
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
        default:
            return ""
        }
    /// Make a http request
    ///
    /// - Parameters:
    ///   - route: A case from the Route Enum
    ///   - method: the http method we're going to use (GET, POST, PUT, DELETE)
    ///   - data: an optional encodable object for when we need to PUT or POST
    ///   - completion: closure that returns the data and the status code from the request
    func fetch(route: Route, method: String, data: Encodable?, completion: @escaping (Data, Int) -> Void) {
        let baseURL = route.baseURl()
        let urlString = baseURL.appending(route.path())
        var toURL = URL(string: urlString)!
        toURL = toURL.appendingQueryParameters(_parametersDictionary: route.urlParameters())
        var request = URLRequest(url: toURL)
        request.httpBody = route.body(data: data)
        request.httpMethod = method
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            completion(data, 200)
            }.resume()
    }
}
class Networking {
  static let instance = Networking()
  let session = URLSession.shared
  
  func fetch(route: Route, method: String, data: Encodable?, completion: @escaping (Data, Int) -> Void) {
        var baseURL = route.baseURl()
        let urlString = baseURL.appending(route.path())
    
        var toURL = URL(string: urlString)!
        if baseURL != "https://api.edamam.com/api/food-database/" {
            toURL = toURL.appendingQueryParameters(_parametersDictionary: route.urlParameters())
        }
        print(toURL)
        var request = URLRequest(url: toURL)
        request.httpBody = route.body(data: data)
        request.httpMethod = method
    
        session.dataTask(with: request) { (data, response, error) in
            print(response)
              let statusCode: Int = (response as!
                HTTPURLResponse).statusCode
              guard let data = data else { return }
              print(data)
              completion(data, statusCode)
        }.resume()
  }
}


/// A protocol to convert get the query parameters returned in a request
protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}



// MARK: - URLQueryParameterStringConvertible
extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@", String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        print(parts.joined(separator: "&"))
        return parts.joined(separator: "&")
    
    /// transform a dictionary of paramenters into a query parameters string
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@", String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        print(parts.joined(separator: "&"))
        return parts.joined(separator: "&")
    }
}

// MARK: - URL extension
extension URL {
    func appendingQueryParameters(_parametersDictionary: Dictionary<String, String>) -> URL {
        let URLString: String = String(format: "%@?%@", self.absoluteString, _parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
    
    /// Append a query parameter string to the url. The parameters string is created from a dictionary
    ///
    /// - Parameter _parametersDictionary: The query parameters Dictionary that will be transformed into a String
    /// - Returns: A URL with the query parameters
    func appendingQueryParameters(_parametersDictionary: Dictionary<String, String>) -> URL {
        let URLString: String = String(format: "%@?%@", self.absoluteString, _parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
