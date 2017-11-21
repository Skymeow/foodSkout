//
//  LowerTableTableViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class LowerTableViewController: UITableViewController {
    
    let goodFoods = ["Walnut", "Salmon", "Banana"]
    let badFoods = ["Walnut", "Salmon", "Banana"]
    var allFoods: [Array<Any>]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.allFoods = [goodFoods, badFoods]
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lowerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LowerTableViewCell
        lowerTableViewCell.imgView.image = UIImage(named: "turmeric")!
        lowerTableViewCell.foodNameLabel.text = "yayewfjsdfjsdfj"
//            allFoods![indexPath.section][indexPath.row] as? String
        lowerTableViewCell.imgView.frame.size.width = lowerTableViewCell.frame.size.height * 0.30
        lowerTableViewCell.imgView.frame.size.height = lowerTableViewCell.frame.size.height * 0.30
        lowerTableViewCell.imgView.contentMode = .scaleAspectFit
        lowerTableViewCell.foodNameLabel.frame.size.width = lowerTableViewCell.frame.size.height * 0.20
        lowerTableViewCell.foodNameLabel.frame.size.height = 35
        
        return lowerTableViewCell
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