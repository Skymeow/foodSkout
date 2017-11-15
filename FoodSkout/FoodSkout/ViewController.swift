//
//  ViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var branded_food_results = [Food]()
    var common_food_results = [Food]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Networking.instance.fetch(route: .food, method: "Get", headers: [:], data: nil) { (data) in

            guard let foods = try? JSONDecoder().decode(Foods.self, from: data) else {return}
            
            DispatchQueue.main.async {
                self.branded_food_results = foods.branded
                self.common_food_results = foods.common
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

