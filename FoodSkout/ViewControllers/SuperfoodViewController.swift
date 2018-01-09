//
//  SuperfoodViewController.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/22/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SuperfoodViewController: UIViewController {
    
    var recipes = ["1 carrot", "2 spoons of salt", "1 spoon of sunflower oil"]
    var superFoodName: String?
    var dataSource = TableViewDataSource(items: [])
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        recipeTableView.delegate = self
        dataSource.configureCell = {(recipeTableView, indexPath) -> UITableViewCell in
            let cell = self.recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
            cell.instructions.text = self.recipes[indexPath.row]
            return cell
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.items = recipes
        self.recipeTableView.dataSource = self.dataSource
        self.recipeTableView.reloadData()
    }
}

extension SuperfoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.recipeTableView.bounds.size.height / CGFloat(self.dataSource.items.count)
        
        return height
    }
}
