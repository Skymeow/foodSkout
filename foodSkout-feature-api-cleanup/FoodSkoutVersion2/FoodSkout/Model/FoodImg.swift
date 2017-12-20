//
//  FoodImg.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/1/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct AllFoodImgs: Codable {
    let hits: [FoodImg]
}

struct FoodImg: Codable {
    var tags: String
    var previewURL: String
    var webformatURL: String
}
