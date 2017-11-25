//
//  LowerTableTableViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

@IBDesignable class LowerTableViewController: UITableViewController {
    
    let goodFoods = ["Walnut", "Salmon", "Banana"]
    let badFoods = ["chips", "poops", "human"]
    var allFoods: [Array<Any>]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.allFoods = [goodFoods, badFoods]
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lowerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LowerTableViewCell
        lowerTableViewCell.imgView.image = UIImage(named: "turmeric")!
        lowerTableViewCell.foodNameLabel.text! = allFoods![indexPath.section][indexPath.row] as! String
        lowerTableViewCell.imgView.contentMode = .scaleAspectFit

        return lowerTableViewCell
    }
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let eachFood = allFoods![indexPath.section][indexPath.row]
    if let nutritionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NutrientsViewController") as? NutrientsViewController {
      present(nutritionVC, animated: true)
    }
  }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let image = UIImage(named: "good")
        let imgView = UIImageView(frame:CGRect(x: 3, y: 3, width: tableView.sectionHeaderHeight, height: tableView.sectionHeaderHeight))
        imgView.image = image
        imgView.contentMode = .scaleAspectFill
        view.addSubview(imgView)
        let label = UILabel(frame: CGRect(x: 10 + tableView.sectionHeaderHeight, y: 3, width: 40, height: tableView.sectionHeaderHeight))
        label.textColor = UIColor.white
        if section == 0 {
            label.text = "good"
            view.backgroundColor = UIColor(red:0.40, green:0.84, blue:0.59, alpha:1.0)
        } else {
            label.text = "Bad"
            view.backgroundColor = UIColor(red:0.94, green:0.22, blue:0.22, alpha:1.0)
        }
        view.addSubview(label)
        
        return view
    }
    
}


