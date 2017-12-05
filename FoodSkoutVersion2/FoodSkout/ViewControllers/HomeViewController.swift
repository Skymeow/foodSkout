 //
//  ViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var foodInfoLabel: UILabel!
    
    @IBOutlet weak var nutritionElement1: UILabel!
    
    @IBOutlet weak var nutritionElement2: UILabel!
    
    @IBOutlet weak var nutritionElement3: UILabel!
    
    @IBOutlet weak var circleElement1: UIButton!
    
    @IBOutlet weak var circleElement2: UIButton!
    
    @IBOutlet weak var circleElement3: UIButton!
    
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
  @IBAction func OrganTabbarButtonTapped(_ sender: UIButton) {
    performSegue(withIdentifier: "toOrgans", sender: nil)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
        /** for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        } */
        self.backgroundImg.image = UIImage(named: "turmeric")!
        
        headerLabel.font = UIFont(name: "Thonburi-Bold", size: 30)
        
        foodInfoLabel.text = "Turmeric is a rhizomatous herbaceous perennial plant of the ginger family, Zingiberaceae. It is native to Southeast Asia"
        foodInfoLabel.numberOfLines = 0
        
        nutritionElement1.text = "Ve"
        nutritionElement2.text = "Vb"
        nutritionElement3.text = "Vc"
        nutritionElement1.textColor = UIColor(red:0.88, green:0.16, blue:0.33, alpha:1.0)
        nutritionElement2.textColor = UIColor(red:0.88, green:0.16, blue:0.33, alpha:1.0)
        nutritionElement3.textColor = UIColor(red:0.88, green:0.16, blue:0.33, alpha:1.0)
        
        circleElement1.setTitle("E", for: .normal)
        circleElement1.setTitleColor(UIColor.white, for: .normal)
        circleElement1.titleLabel?.font = UIFont(name: "Thonburi-Bold", size: 38)
        circleElement1.layer.cornerRadius = 0.5 * circleElement1.bounds.width
        
        circleElement2.setTitle("B", for: .normal)
        circleElement2.setTitleColor(UIColor.white, for: .normal)
        circleElement2.titleLabel?.font = UIFont(name: "Thonburi-Bold", size: 38)
        circleElement2.layer.cornerRadius = 0.5 * circleElement2.bounds.width
        
        circleElement3.setTitle("C", for: .normal)
        circleElement3.setTitleColor(UIColor.white, for: .normal)
        circleElement3.titleLabel?.font = UIFont(name: "Thonburi-Bold", size: 38)
        circleElement3.layer.cornerRadius = 0.5 * circleElement3.bounds.width
        
        pinBackground(backgroundButtonView, to: buttonStackView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundButtonView.addBorder(side: .top, thickness: 0.65, color: UIColor(red:0.78, green:0.58, blue:0.58, alpha:1.0), leftOffset: 0, rightOffset: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

