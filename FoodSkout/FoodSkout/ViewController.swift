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
    
    var nutrients_dict = Dictionary<Int,String>()

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
        parseNutrientsCSV()
    }
    
    //Parse CSV
    func parseNutrientsCSV() {
        let path = Bundle.main.path(forResource: "Sheet1", ofType: "csv")!

        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows

            for row in rows {
                let pokeId = Int(row["attr_id"]!)!
                let name = row["name"]!

                nutrients_dict[pokeId] = name
                
            }
            
            print(nutrients_dict)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

