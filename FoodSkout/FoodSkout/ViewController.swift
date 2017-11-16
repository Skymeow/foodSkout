//
//  ViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Networking.instance.fetch(route: .food, method: "Get", headers: [:], data: nil) { (data) in
//             let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let foods = try? JSONDecoder().decode(Foods.self, from: data)
            for food in (foods?.common)! {
                print(food)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

