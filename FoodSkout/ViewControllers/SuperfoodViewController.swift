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
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    func setRecipeLabels(_ label: UILabel, _ int: Int) {
        let recipeName = self.recipeData?.recipe.label
        let recipeInstruction = self.recipeData?.recipe.ingredientLines
        let num = (recipeInstruction?.count)! - 1

        for i in 1...num {
            let format = "\(i). %@\n"
            let result = String(format: format, arguments: [recipeInstruction![i] as CVarArg])
            self.recipeInstructions.append(result)
        }
        DispatchQueue.main.async {
            label.text = self.recipeInstructions[int]
        }
    }
    
//    func setRecipeImg() {
//        let imgString = self.recipeData?.recipe.image
//        let imgUrl = URL(string: imgString!)
//        let data = try? Data(contentsOf: imgUrl!)
//        if let data = data {
//            DispatchQueue.main.async {
//                self.recipeViewController?.recipeImg.contentMode = .scaleAspectFill
//                self.recipeViewController?.recipeImg.image = UIImage(data: data)
//            }
//        }
//    }
    func getRecipe(completion: @escaping(Bool) -> Void){
        Networking.instance.fetch(route: .recipe(foodName: self.superFoodName!), method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode(Recipe.self, from: data)
                guard let results = result else { return }
                self.recipeData = results.hits[0]
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
                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.delegate = self
        dataSource.configureCell = {(recipeTableView, indexPath) -> UITableViewCell in
            let cell = self.recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
            self.setRecipeLabels(cell.instructions, indexPath.row)
            
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
