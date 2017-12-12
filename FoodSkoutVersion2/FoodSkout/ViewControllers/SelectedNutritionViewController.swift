//
//  SelectedNutritionViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/11/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SelectedNutritionViewController: UIViewController {
    var foodName: String?
    var foodUri: String?
    
    @IBOutlet weak var percentageBar1: PercentageBar!
    
    @IBOutlet weak var percentageBar2: PercentageBar!
    
    @IBOutlet weak var percentageBar3: PercentageBar!
    
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    @IBOutlet weak var nutrientLabel1: UILabel!
    
    @IBOutlet weak var nutrientLabel2: UILabel!
    
    @IBOutlet weak var nutrientLabel3: UILabel!
    
    func getLabelData() {
        let ingredientObj = Ingredient(quantity: 1, measureURI: "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram", foodURI: self.foodUri!)
        let foodLabelObj = IngredientBody(yield: 1, ingredients: [ingredientObj])
        Networking.instance.fetch(route: .getNutrientsLabel, method: "POST", data: foodLabelObj) { (data, response) in
            if response == 200 {
                let decoder = JSONDecoder()
                let res = try? decoder.decode(IngredientResult.self, from: data)
                guard let healthLabelResult = res?.healthLabels, let dietLabelResult = res?.dietLabels, let primeNutrients = res?.totalNutrients else { return }
                print(healthLabelResult, dietLabelResult, primeNutrients)
                let labelCombine = healthLabelResult.joined(separator: ", ")
                let base1 = primeNutrients.SUGAR.quantity
                
                let base2 = primeNutrients.FAT.quantity
                
                let base3 = primeNutrients.PROCNT.quantity

                let totalBase = base1 + base2 + base3
                let proteinPerc = base3 / totalBase
                let fatPerc = base2 / totalBase
                let sugarPerc = base1 / totalBase
                DispatchQueue.main.async {
                    self.foodDescriptionLabel.attributedText = self.makeAttributedStr(labelStr: labelCombine, lineSpacing: 10)
                    self.percentageBar1.value = sugarPerc
                    self.percentageBar2.value = fatPerc
                    self.percentageBar3.value = proteinPerc
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getLabelData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectedNutritionViewController {
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
