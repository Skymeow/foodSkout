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
    let dataSource = TagsCollectionDatasource(items: [])
    var healthLabelData: [String] = []
    var sugarPerc: Float?
    var fatPerc: Float?
    var proteinPerc: Float?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var percentageBar1: PercentageBar!
    
    @IBOutlet weak var percentageBar2: PercentageBar!
    
    @IBOutlet weak var percentageBar3: PercentageBar!
    
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    @IBOutlet weak var nutrientLabel1: UILabel!
    
    @IBOutlet weak var nutrientLabel2: UILabel!
    
    @IBOutlet weak var nutrientLabel3: UILabel!
    
    func getLabelData(completion: @escaping (Bool) -> Void) {
        let ingredientObj = Ingredient(quantity: 1, measureURI: "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram", foodURI: self.foodUri!)
        let foodLabelObj = IngredientBody(yield: 1, ingredients: [ingredientObj])
        Networking.instance.fetch(route: .getNutrientsLabel, method: "POST", data: foodLabelObj) { (data, response) in
            if response == 200 {
                let decoder = JSONDecoder()
                let res = try? decoder.decode(IngredientResult.self, from: data)
                guard let healthLabelResult = res?.healthLabels, let dietLabelResult = res?.dietLabels, let primeNutrients = res?.totalNutrients else { return }
                self.healthLabelData = healthLabelResult
               
//                let labelCombine = healthLabelResult.joined(separator: ", ")
                let base1 = primeNutrients.SUGAR.quantity
                
                let base2 = primeNutrients.FAT.quantity
                
                let base3 = primeNutrients.PROCNT.quantity

                let totalBase = base1 + base2 + base3
                self.proteinPerc = base3 / totalBase
                self.fatPerc = base2 / totalBase
                self.sugarPerc = base1 / totalBase
                completion(true)
//                DispatchQueue.main.async {
////                    self.foodDescriptionLabel.attributedText = self.makeAttributedStr(labelStr: labelCombine, lineSpacing: 10)
//                    self.percentageBar1.value = sugarPerc
//                    self.percentageBar2.value = fatPerc
//                    self.percentageBar3.value = proteinPerc
//                }
            }
        }
    }
    
    func setPercentagesbar() {
//        DispatchQueue.main.async {
            //                    self.foodDescriptionLabel.attributedText = self.makeAttributedStr(labelStr: labelCombine, lineSpacing: 10)
            self.percentageBar1.value = self.sugarPerc!
            self.percentageBar2.value = self.fatPerc!
            self.percentageBar3.value = self.proteinPerc!
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getLabelData { (success) in
            if success {
                DispatchQueue.main.async {
                    self.setPercentagesbar()
                    self.collectionView.dataSource = self.dataSource
                    self.dataSource.items = self.healthLabelData
                    self.collectionView.reloadData()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        
        let tagCell = UINib(nibName: "TagsCell", bundle: Bundle.main)
        collectionView.register(tagCell, forCellWithReuseIdentifier: "TagsCell")
        dataSource.configureCell = { (collectionView, indexPath) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
            cell.label.text = self.healthLabelData[indexPath.row]
//            cell.delegate = self
            return cell
        }
    }
}

extension SelectedNutritionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 45)
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
