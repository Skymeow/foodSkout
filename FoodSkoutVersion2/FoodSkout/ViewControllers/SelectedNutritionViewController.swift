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
    var sugarPerc: Float?
    var fatPerc: Float?
    var proteinPerc: Float?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var percentageBar1: PercentageBar!
    @IBOutlet weak var percentageBar2: PercentageBar!
    @IBOutlet weak var percentageBar3: PercentageBar!
    @IBOutlet weak var nutrientLabel1: UILabel!
    @IBOutlet weak var nutrientLabel2: UILabel!
    @IBOutlet weak var nutrientLabel3: UILabel!
    
    func getLabelData(completion: @escaping (Bool) -> Void) {
        if self.foodUri != nil {
        let ingredientObj = Ingredient(quantity: 1, measureURI: "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram", foodURI: self.foodUri!)
        let foodLabelObj = IngredientBody(yield: 1, ingredients: [ingredientObj])
        Networking.instance.fetch(route: .getNutrientsLabel, method: "POST", data: foodLabelObj) { (data, response) in
            if response == 200 {
                let decoder = JSONDecoder()
                let res = try? decoder.decode(IngredientResult.self, from: data)
                
                guard let labelResult = res else { return }
                let healthLabelResult = res!.healthLabels
                let primeNutrients = res!.totalNutrients
                self.healthLabelData = healthLabelResult
                let base1 = primeNutrients.SUGAR?.quantity
                let base2 = primeNutrients.FAT?.quantity
                let base3 = primeNutrients.PROCNT?.quantity
                if base1 != nil &&  base2 != nil &&  base3 != nil {
                    let totalBase = Float(base1!) + Float(base2!) + Float(base3!)
                    self.proteinPerc = Float(base3!) / Float(totalBase)
                    self.fatPerc = Float(base2!) / Float(totalBase)
                    self.sugarPerc = Float(base1!) / Float(totalBase)
                }
                completion(true)
                
                }
            }
        }
    }
    
    func setPercentagesbar() {
        if self.sugarPerc != nil && self.fatPerc != nil && self.proteinPerc != nil {
            self.percentageBar1.value = self.sugarPerc!
            self.percentageBar2.value = self.fatPerc!
            self.percentageBar3.value = self.proteinPerc!
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
            } 
            return cell
        }
    }
}

extension SelectedNutritionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 45)
    }
}
