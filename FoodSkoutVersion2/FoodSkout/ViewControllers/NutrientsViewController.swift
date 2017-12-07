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
    
    var foodUri: String?
    
    var zippedResult: Any?
    @IBOutlet weak var percentageBar1: PercentageBar!
    
    @IBOutlet weak var percentageBar2: PercentageBar!
    
    @IBOutlet weak var percentageBar3: PercentageBar!
    
    @IBOutlet weak var foodImgView: UIImageView!
    
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    @IBOutlet weak var nutrientLabel1: UILabel!
    
    @IBOutlet weak var nutrientLabel2: UILabel!
    
    @IBOutlet weak var nutrientLabel3: UILabel!
    
    @IBOutlet weak var buttonView: UIStackView!
    
    func getFoodImg(completion: @escaping (Bool) -> Void) {
        Networking.instance.fetch(route: .foodImg(foodImgQuery: foodName!), method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(AllFoodImgs.self, from: data)
                guard let foodImgsData = result?.hits else { return }
                print(foodImgsData)
                self.foodImgs = foodImgsData
                
                completion(true)
            }
        }
    }
    
    func setCorrectImg() {
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
    
    func getLabelData() {
        let ingredientObj = Ingredient(quantity: 1, measureURI: "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram", foodURI: self.foodUri!)
        let foodLabelObj = IngredientBody(yield: 1, ingredients: [ingredientObj])
        Networking.instance.fetch(route: .getNutrientsLabel, method: "POST", data: foodLabelObj) { (data, response) in
            if response == 200 {
                let decoder = JSONDecoder()
                let res = try? decoder.decode(IngredientResult.self, from: data)
                guard let healthLabelResult = res?.healthLabels, let dietLabelResult = res?.dietLabels else { return }
                print(healthLabelResult, dietLabelResult)
                let labelCombine = healthLabelResult.joined(separator: ", ")
                DispatchQueue.main.async {
                    self.foodDescriptionLabel.attributedText = self.makeAttributedStr(labelStr: labelCombine, lineSpacing: 10)
                }
            }
        }
    }
    
    
    @IBAction func OrganNavBarButtonTapped(_ sender: UIButton) {
        
        if let organVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "organVC") as? ChooseOrgansViewController {
            self.navigationController?.pushViewController(organVC, animated: true)
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
                self.setCorrectImg()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        getLabelData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.buttonView.addBorder(side: .top, thickness: 0.65, color: UIColor(red:0.78, green:0.58, blue:0.58, alpha:1.0), leftOffset: 0, rightOffset: 0)
    }

}

extension NutrientsViewController {
    func makeAttributedStr(labelStr: String, lineSpacing: CGFloat = 1.5) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: labelStr)
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = lineSpacing // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))
        // *** Set Attributed String to your label ***
//        label.attributedText = attributedString;
        return attributedString
    }
}