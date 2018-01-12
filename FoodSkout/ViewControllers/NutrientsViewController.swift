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
    var checkIfLoaded: Bool = false
    var foodImgUrl: String?
    
    fileprivate var selectedNutritionViewController: SelectedNutritionViewController?
    fileprivate var recipeViewController: RecipeViewController?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var nutritionButton: UIButton!
    @IBOutlet weak var foodImgView: UIImageView!
    
   // MARK: IBActions for buttons within VC
    
    @IBAction func selectedNutriTapped(_ sender: UIButton) {
        self.recipeViewController?.view.isHidden = true
        self.selectedNutritionViewController?.view.isHidden = false
        selectTab(button: sender)
        resetButtons(button: sender)
    }
    
    @IBAction func selectedReciTapped(_ sender: UIButton) {
        self.recipeViewController?.view.isHidden = false
        self.selectedNutritionViewController?.view.isHidden = true
        selectTab(button: sender)
        resetButtons(button: sender)
        // If the data has been loaded previously no need to load it again.
        if  self.checkIfLoaded == false {
            showLoadingAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.setCorrectImg()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let recipeController = childViewControllers.first as? RecipeViewController else {
            fatalError("Check storyboard for missing recipeViewController")
        }
        
        guard let selectedNutritionController = childViewControllers.last as? SelectedNutritionViewController else  {
            fatalError("Check storyboard for missing selectedNutritionViewController")
        }
        
        selectedNutritionViewController = selectedNutritionController
        recipeViewController = recipeController
        selectedNutritionViewController?.foodUri = self.foodUri
        self.recipeViewController?.view.isHidden = true
        self.selectedNutritionViewController?.view.isHidden = false
    }
    
    func showLoadingAlert() {
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        Networking.instance.fetch(route: .recipe(foodName: self.foodName!), method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(Recipe.self, from: data)
                guard let results = result else { return }
                self.recipeData = results.hits[0]
                self.setRecipeImg()
                self.setRecipeLabels()
                self.checkIfLoaded = true
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func selectTab (button: UIButton) {
        // set recipt buttons to grey background color, nutri button background back to green
        if button == self.nutritionButton {
            button.setTitleColor(UIColor.white, for: .normal)
        } else {
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func resetButtons (button: UIButton) {
        if button == nutritionButton {
            self.recipeButton.setTitleColor(UIColor.darkGray, for: .normal)
        } else {
            self.nutritionButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
    }
   
    func setRecipeLabels() {
        let recipeName = self.recipeData?.recipe.label
        let recipeInstruction = self.recipeData?.recipe.ingredientLines
        let num = (recipeInstruction?.count)! - 1
        var results = ""
        for i in 1...num {
            let format = "\(i). %@\n"
            let result = String(format: format, arguments: [recipeInstruction![i] as CVarArg])
            results += result
        }
        DispatchQueue.main.async {
            self.recipeViewController?.recipeName.text = recipeName
            self.recipeViewController?.recipeLabel.text = results
        }
    }
    
    func setRecipeImg() {
        let imgString = self.recipeData?.recipe.image
        let imgUrl = URL(string: imgString!)
        let data = try? Data(contentsOf: imgUrl!)
        if let data = data {
            DispatchQueue.main.async {
                self.recipeViewController?.recipeImg.contentMode = .scaleAspectFill
                self.recipeViewController?.recipeImg.image = UIImage(data: data)
            }
        }
    }
    
    func setCorrectImg() {
        let foodImgString = self.foodImgUrl
        if self.foodImgUrl != nil {
        let foodImgUrl = URL(string: foodImgString!)
        let data = try? Data(contentsOf: foodImgUrl!)
        DispatchQueue.main.async {
            if let data = data {
                self.foodImgView.contentMode = .scaleAspectFill
                self.foodImgView.image = UIImage(data: data)
            }
        }
        }
    }

}

