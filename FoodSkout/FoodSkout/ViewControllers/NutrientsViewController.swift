//
//  NutrientsViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/24/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

typealias completed = (Bool) -> Void

class NutrientsViewController: UIViewController {
    
    var foodName: String?
    
    var foodImgs: [FoodImg] = []

    @IBOutlet weak var percentageBar1: PercentageBar!

    @IBOutlet weak var percentageBar2: PercentageBar!

    @IBOutlet weak var percentageBar3: PercentageBar!
  
    @IBOutlet weak var foodImgView: UIImageView!

    @IBOutlet weak var foodDescriptionLabel: UILabel!

    @IBOutlet weak var nutrientLabel1: UILabel!

    @IBOutlet weak var nutrientLabel2: UILabel!

    @IBOutlet weak var nutrientLabel3: UILabel!
    
    func getFoodImg(completion: @escaping (Bool) -> Void) {
        Networking.instance.fetch(route: .foodImg(foodImgQuery: foodName!), method: "GET") { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(AllFoodImgs.self, from: data)
                guard let foodImgsData = result?.hits else { return }
                print(foodImgsData)
                self.foodImgs = foodImgsData

                completion(true)
            }
        }
    }
    
    func getCorrectImg() {
        let foodImgString = self.foodImgs[0].webformatURL
        let foodImgUrl = URL(string: foodImgString)
        let data = try? Data(contentsOf: foodImgUrl!)
        DispatchQueue.main.async {
            if let data = data {
                self.foodImgView.image = UIImage(data: data)
            }
        }
    }
    
    func handleFunctionOrder(completion: @escaping completed) {
//       call getFoodImg() first then do the following
        self.getFoodImg { (success) in
            if success{
                completion(true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        percentageBar1.value = 0.75
        percentageBar2.value = 0.45
        percentageBar3.value = 0.25
        self.handleFunctionOrder { (success) -> Void in
            if success {
                // call this function first, then call whatever's inside of handleOrder
                self.getCorrectImg()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
