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
    let dataSource = CollectionViewDataSource(items: [])
    var healthLabelData: [String]?
    var nutrient1: Float?
    var nutrient2: Float?
    var nutrient3: Float?
    var fNu: [Nutrient]?
    var base1: Float?
    var base2: Float?
    var base3: Float?
   
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
        let ingredientObj = Ingredient(quantity: 1, measureURI: "http://www.edamam.com/ontologies/edamam.owl#Measure_gram", foodURI: self.foodUri!)
        let foodLabelObj = IngredientBody(yield: 1, ingredients: [ingredientObj])
        Networking.instance.fetch(route: .getNutrientsLabel, method: "POST", data: foodLabelObj) { (data, response) in
            if response == 200 {
                let decoder = JSONDecoder()
                let res = try? decoder.decode(IngredientResult.self, from: data)
                guard let nutrients = res?.totalDaily.values.reversed() else {return}
                self.fNu = nutrients.sorted(by: { (a, b) -> Bool in
                    a > b
                })
                guard let labelResult = res else { return }
                let healthLabelResult = labelResult.healthLabels
                self.healthLabelData = healthLabelResult
                completion(true)
                }
            }
        }
    }
    
    func setNutritionbarValue() {
        if self.fNu != nil {
            self.base1 = self.fNu![0].quantity
            self.base2 = self.fNu![1].quantity
            self.base3 = self.fNu![2].quantity
            let totalBase = self.base1! + self.base2! + self.base3!
            self.nutrient3 = self.base3! / Float(totalBase)
            self.nutrient2 = self.base2! / Float(totalBase)
            self.nutrient1 = self.base1! / Float(totalBase)
        }
    }
    
    func setPercentagesbar() {
        setNutritionbarValue()
        let PrettyPercent1 = String(format: "%.2f", arguments: [self.base1!])
         let PrettyPercent2 = String(format: "%.2f", arguments: [self.base2!])
         let PrettyPercent3 = String(format: "%.2f", arguments: [self.base3!])
        
        self.nutrientLabel1.text = self.fNu![0].label
        self.nutrientLabel2.text = self.fNu![1].label
        self.nutrientLabel3.text = self.fNu![2].label
    
        self.percentLabel1.text = "\(PrettyPercent1)%"
        self.percentLabel2.text = "\(PrettyPercent2)%"
        self.percentLabel3.text = "\(PrettyPercent3)%"
    
        self.percentageBar1.value = self.nutrient1!
        self.percentageBar2.value = self.nutrient2!
        self.percentageBar3.value = self.nutrient3!
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
                cell.label.adjustsFontSizeToFitWidth = true
            } 
            return cell
        }
    }
}

extension SelectedNutritionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 45)
    }
}
