//
//  CustomNavigationController.swift
//  FoodSkout
//
//  Created by Sky Xu on 1/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(red: 252/255, green: 248/255, blue: 249/255, alpha: 1.0)
        self.navigationBar.tintColor = UIColor(red: 241/255, green: 36/255, blue: 120/255, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 241/255, green: 36/255, blue: 120/255, alpha: 1.0)]
        self.navigationBar.shadowImage = UIImage()
        
    }
}
