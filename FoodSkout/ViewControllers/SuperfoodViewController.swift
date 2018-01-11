//
//  SuperfoodViewController.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/22/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SuperfoodViewController: UIViewController {
    
    var superFoodName: String?
    var dataSource = TableViewDataSource(items: [])
    var recipeData: Recipes?
    var recipeInstructions = [String]()
    var stepArr = [String]()
    
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    
    func setRecipeLabels(_ label1: UILabel, _ label2: UILabel, _ int: Int) {
        let recipeName = self.recipeData?.recipe.label
        DispatchQueue.main.async {
            label1.text = self.recipeInstructions[int]
            label2.text = self.stepArr[int]
            self.recipeNameLabel.text = recipeName
        }
    }
    
    func setRecipeImg() {
        let imgString = self.recipeData?.recipe.image
        let imgUrl = URL(string: imgString!)
        let data = try? Data(contentsOf: imgUrl!)
        if let data = data {
            DispatchQueue.main.async {
                self.recipeImg.contentMode = .scaleAspectFill
                self.recipeImg.image = UIImage(data: data)
            }
        }
    }
    
    func getRecipe(completion: @escaping(Bool) -> Void){
        Networking.instance.fetch(route: .recipe(foodName: self.superFoodName!), method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(Recipe.self, from: data)
                guard let results = result else { return }
                self.recipeData = results.hits[0]
                let recipeInstruction = self.recipeData!.recipe.ingredientLines
                let num = (recipeInstruction.count) - 1
                for i in 1...num {
                    let result = recipeInstruction[i].replacingOccurrences(of: "Â", with: "")
                    let stepResult = "Step \(i)"
                    self.recipeInstructions.append(result)
                    self.stepArr.append(stepResult)
                }
                
                completion(true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.getRecipe{ (success) in
            if success {
                self.dataSource.items = self.recipeInstructions
                DispatchQueue.main.async {
                    self.recipeTableView.dataSource = self.dataSource
                    self.recipeTableView.reloadData()
                    self.setRecipeImg()
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTableView.delegate = self
        dataSource.configureCell = {(recipeTableView, indexPath) -> UITableViewCell in
            let cell = self.recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
            self.setRecipeLabels(cell.instructions, cell.step, indexPath.row)
            
            return cell
        }
       
    }
}

extension SuperfoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.recipeTableView.bounds.size.height / CGFloat(self.dataSource.items.count)
        
        return height
    }
}