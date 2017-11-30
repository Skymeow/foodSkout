//
//  PickOrganViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class DisplayOrganViewController: UIViewController {
    
    var organName: String?
    
    var row: Int?
    
    @IBOutlet weak var organImg: UIImageView!
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var lowerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(row)
        let organUIImg = UIImage(named: "Organ\(row)")
        self.organImg.image = organUIImg
        
        Networking.instance.fetch(route: .organs(organName: organName!), method: "GET") { (data, response) in
              if response == 200 {
                let organ = try? JSONDecoder().decode(Organ.self, from: data)
                guard let good = organ?.goodFoods,
                let bad =  organ?.badFoods else { return }
                self.goodFoods = good; self.badFoods = bad
                DispatchQueue.main.async {
                    self.lowerTableView.reloadData()
                }
              }
        }
    }
    
    var goodFoods = ["Walnut", "Salmon", "Banana"]
    var badFoods = ["chips", "poops", "human"]
}

extension DisplayOrganViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lowerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LowerTableViewCell
        lowerTableViewCell.imgView.image = UIImage(named: "turmeric")!
        if indexPath.section == 0 {
            lowerTableViewCell.foodNameLabel.text? = goodFoods[indexPath.row]
        } else {
            lowerTableViewCell.foodNameLabel.text? = badFoods[indexPath.row]
        }
        lowerTableViewCell.imgView.contentMode = .scaleAspectFit
        
        return lowerTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nutritionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NutrientsViewController") as? NutrientsViewController {
            if indexPath.section == 0 {
                nutritionVC.foodName = goodFoods[indexPath.row]
            } else {
                nutritionVC.foodName = badFoods[indexPath.row]
            }
            present(nutritionVC, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
