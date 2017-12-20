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
    var healthLabelData: [String]?
    var nutrient1: Float?
    var nutrient2: Float?
    var nutrient3: Float?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var percentageBar1: PercentageBar!
    @IBOutlet weak var percentageBar2: PercentageBar!
    @IBOutlet weak var percentageBar3: PercentageBar!
    @IBOutlet weak var nutrientLabel1: UILabel!
    @IBOutlet weak var nutrientLabel2: UILabel!
    @IBOutlet weak var nutrientLabel3: UILabel!
    @IBOutlet weak var percentLabel1: UILabel!
    @IBOutlet weak var percentLabel2: UILabel!
    @IBOutlet weak var percentLabel3: UILabel!
    
    func getLabelData(completion: @escaping (Bool) -> Void) {
        if self.foodUri != nil {
        let ingredientObj = Ingredient(quantity: 1, measureURI: "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram", foodURI: self.foodUri!)
        let foodLabelObj = IngredientBody(yield: 1, ingredients: [ingredientObj])
        Networking.instance.fetch(route: .getNutrientsLabel, method: "POST", data: foodLabelObj) { (data, response) in
            if response == 200 {
                let decoder = JSONDecoder()
                let res = try? decoder.decode(IngredientResult.self, from: data)
                
                guard var nutrients = res?.totalDaily.values.reversed() else {return}
                
                var fNu = nutrients.sorted(by: { (a, b) -> Bool in
                    a > b
                })
                
                print(fNu)
                
                
                guard let labelResult = res else { return }
                let healthLabelResult = res!.healthLabels
                let primeNutrients = res!.totalNutrients
                self.healthLabelData = healthLabelResult
                
                DispatchQueue.main.async {
                    self.nutrientLabel1.text = fNu[0].label
                    self.nutrientLabel2.text = fNu[1].label
                    self.nutrientLabel3.text = fNu[2].label
                    
                    self.percentLabel1.text = "\(fNu[0].quantity)\(fNu[0].unit)"
                    self.percentLabel2.text = "\(fNu[1].quantity)\(fNu[1].unit)"
                    self.percentLabel3.text = "\(fNu[2].quantity)\(fNu[2].unit)"
                }
                
                let base1 = fNu[0].quantity
                let base2 = fNu[1].quantity
                let base3 = fNu[2].quantity
                let totalBase = Float(base1) + Float(base2) + Float(base3)
                self.nutrient3 = Float(base3) / Float(totalBase)
                self.nutrient2 = Float(base2) / Float(totalBase)
                self.nutrient1 = Float(base1) / Float(totalBase)
                completion(true)
                
                }
            }
        }
    }
    
    func setPercentagesbar() {
        if self.nutrient1 != nil && self.nutrient2 != nil && self.nutrient3 != nil {
            self.percentageBar1.value = self.nutrient1!
            self.percentageBar2.value = self.nutrient2!
            self.percentageBar3.value = self.nutrient3!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getLabelData { (success) in
            if success {
                DispatchQueue.main.async {
                    self.setPercentagesbar()
                    self.dataSource.items = self.healthLabelData!
                    
                    self.collectionView.dataSource = self.dataSource
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
            if self.healthLabelData?[0] != nil {
                cell.label.text = self.healthLabelData![indexPath.row]
                cell.label.font = UIFont(name: "Avenir Next", size: 12)
                cell.label.adjustsFontSizeToFitWidth = true
                
            } 
            return cell
        }
    }
}

extension SelectedNutritionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 30)
    }
}
