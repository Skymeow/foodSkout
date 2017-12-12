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
    
    var recipeData: Recipes?
    
    @IBOutlet weak var foodImgView: UIImageView!
    
    fileprivate var selectedNutritionViewController: SelectedNutritionViewController?
    
    fileprivate var recipeViewController: RecipeViewController?
    
    @IBAction func selectedNutriTapped(_ sender: UIButton) {
        self.recipeViewController?.view.isHidden = true
        self.selectedNutritionViewController?.view.isHidden = false
    }
    
    @IBAction func selectedReciTapped(_ sender: UIButton) {
        self.recipeViewController?.view.isHidden = false
        self.selectedNutritionViewController?.view.isHidden = true
        
        Networking.instance.fetch(route: .recipe(foodName: self.foodName!), method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(Recipe.self, from: data)
                guard let results = result else { return }
                self.recipeData = results.hits[0]
                self.setRecipeImg()
            }
        }
        
    }
   
    func setRecipeLabels() {
        let recipeName = self.recipeData?.recipe.label
        let recipeInstruction = self.recipeData?.recipe.ingredientLines
        let num = recipeInstruction?.count
        let format = ""
//        for i in 0..< num {
//            format = "i. %@/n"
//        }
//        let result = String(format: format, arguments: recipeInstruction)
//        for i in recipeInstruction!.count {
//            let instuctions = ""
//            instructions += recipeInstruction?.joined(separator: "i. ")
//        }
        
    }
    
    func setRecipeImg() {
        let imgString = self.recipeData?.recipe.image
        let imgUrl = URL(string: imgString!)
        let data = try? Data(contentsOf: imgUrl!)
        if let data = data {
            DispatchQueue.main.async {
                self.recipeViewController?.recipeImg.contentMode = .scaleAspectFit
                self.recipeViewController?.recipeImg.image = UIImage(data: data)
            }
        }
    }
    
    func getFoodImg(completion: @escaping (Bool) -> Void) {
        Networking.instance.fetch(route: .foodImg(foodImgQuery: foodName!), method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(AllFoodImgs.self, from: data)
                guard let foodImgsData = result?.hits else { return }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.handleFunctionOrder { (success) -> Void in
            if success {
                // call this function first, then call whatever's inside of handleOrder
                self.setCorrectImg()
            }
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        guard let selectedNutritionController = childViewControllers.first as? SelectedNutritionViewController else  {
            fatalError("Check storyboard for missing selectedNutritionViewController")
        }
        
        guard let recipeController = childViewControllers.last as? RecipeViewController else {
            fatalError("Check storyboard for missing recipeViewController")
        }
        
        selectedNutritionViewController = selectedNutritionController
        recipeViewController = recipeController
        selectedNutritionViewController?.foodUri = self.foodUri
        print(foodUri)
//        recipeViewController?.foodName = self.foodName
        self.recipeViewController?.view.isHidden = true
        self.selectedNutritionViewController?.view.isHidden = false
    }

}

