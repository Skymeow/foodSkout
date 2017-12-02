//
//  Organ.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/29/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct JSONOrgan: Codable {
    var goodFoods: [String]?
    var badFoods: [String]?
    var organName: String?
    
    enum CodingKeys: String, CodingKey {
        case goodFoods
        case badFoods
        case organName = "organ_name"
    }
}
