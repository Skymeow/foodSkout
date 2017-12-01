//
//  NetWorking.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

enum Route {
  case organs(organName: String)
  case foods
  case foodImg(foodImgQuery: String)
  
  func path() -> String {
    switch self {
    case .organs:
      return "organs"
    case .foods:
      return "foods"
    case .foodImg:
        return ""
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
    default:
      return [:]
    }
  }
    
    func baseURl() -> String {
        switch self {
        case .organs:
            return "http://127.0.0.1:5000/"
        case .foods:
            return ""
        case .foodImg:
            return "https://pixabay.com/api/"
        default:
            return ""
        }
    }
}
class Networking {
  static let instance = Networking()
//  var baseURL = "https://foodskout.herokuapp.com/"
//  var baseURL = "http://127.0.0.1:5000/"
  let session = URLSession.shared
  
  func fetch(route: Route, method: String, completion: @escaping (Data, Int) -> Void) {
    var baseURL = route.baseURl()
    let urlString = baseURL.appending(route.path())
    var toURL = URL(string: urlString)!
    toURL = toURL.appendingQueryParameters(_parametersDictionary: route.urlParameters())
    var request = URLRequest(url: toURL)
    
//    request.allHTTPHeaderFields = headers
    request.httpMethod = method
    
    session.dataTask(with: request) { (data, response, error) in
      let statusCode: Int = (response as?
        HTTPURLResponse)!.statusCode
      guard let data = data else { return }
      print(data)
      completion(data, statusCode)
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
    print(parts.joined(separator: "&"))
    return parts.joined(separator: "&")
  }
}

extension URL {
  func appendingQueryParameters(_parametersDictionary: Dictionary<String, String>) -> URL {
    let URLString: String = String(format: "%@?%@", self.absoluteString, _parametersDictionary.queryParameters)
    return URL(string: URLString)!
  }
}


