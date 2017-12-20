//
//  FakeNutrientsViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/14/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class FakeNutrientsViewController: UIViewController {
    
    var checkIfLoaded: Bool = false
    fileprivate var selectedNutritionViewController: FakeSelectedNutritionViewController?
    fileprivate var recipeViewController: FakeRecipeViewController?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var nutritionButton: UIButton!
    @IBOutlet weak var foodImgView: UIImageView!
    @IBOutlet weak var buttonView: UIStackView!
    
    
    // MARK: IBActions for Botttom Tabbar
    
    @IBAction func homeTapped(_ sender: UIButton) {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as? HomeViewController
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(homeVC!, animated: true)
        }
    }
    
    @IBAction func organTapped(_ sender: UIButton) {
        let organVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseOrgansViewController") as? ChooseOrgansViewController
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(organVC!, animated: true)
        }
    }
    
    // MARK: IBActions for buttons within VC
    
    @IBAction func selectedNutriTapped(_ sender: UIButton) {
        self.recipeViewController?.view.isHidden = true
        self.selectedNutritionViewController?.view.isHidden = false
        selectTab(button: sender)
        resetButtons(button: self.recipeButton)
    }
    
    @IBAction func selectedReciTapped(_ sender: UIButton) {
        self.recipeViewController?.view.isHidden = false
        self.selectedNutritionViewController?.view.isHidden = true
        selectTab(button: sender)
        resetButtons(button: self.nutritionButton)
    }
    
    func resetButtons (button: UIButton) {
        // set both buttons to default background color
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func selectTab(button: UIButton) {
        if button == nutritionButton {
            button.backgroundColor = UIColor(red: 0.7216, green: 0.8314, blue: 0.6549, alpha: 1.0)
        } else {
            button.backgroundColor = UIColor(white: 0, alpha: 0.47)
        }
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonView.addBorder(side: .top, thickness: 0.65, color: UIColor(red:0.78, green:0.58, blue:0.58, alpha:1.0), leftOffset: 0, rightOffset: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let recipeController = childViewControllers.first as? FakeRecipeViewController else {
            fatalError("Check storyboard for missing recipeViewController")
        }
        
        guard let selectedNutritionController = childViewControllers.last as? FakeSelectedNutritionViewController else  {
            fatalError("Check storyboard for missing selectedNutritionViewController")
        }
        
        selectedNutritionViewController = selectedNutritionController
        recipeViewController = recipeController
        self.recipeViewController?.view.isHidden = true
        self.selectedNutritionViewController?.view.isHidden = false
    }

}
