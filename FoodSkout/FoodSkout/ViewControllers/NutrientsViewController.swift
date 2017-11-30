//
//  NutrientsViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/24/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class NutrientsViewController: UIViewController {
    
    var foodName: String?

    @IBOutlet weak var percentageBar1: PercentageBar!

    @IBOutlet weak var percentageBar2: PercentageBar!

    @IBOutlet weak var percentageBar3: PercentageBar!
  
    @IBOutlet weak var foodImgView: UIImageView!

    @IBOutlet weak var foodDescriptionLabel: UILabel!

    @IBOutlet weak var nutrientLabel1: UILabel!

    @IBOutlet weak var nutrientLabel2: UILabel!

    @IBOutlet weak var nutrientLabel3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        percentageBar1.value = 0.75
        percentageBar2.value = 0.45
        percentageBar3.value = 0.25
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
