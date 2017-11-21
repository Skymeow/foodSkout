//
//  LowerTableViewCell.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class LowerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.imgView.frame.size.width = self.frame.size.height * 0.85
//        self.imgView.frame.size.height = self.frame.size.height * 0.85
//        self.imgView.contentMode = .scaleAspectFit
////        self.imgView.image = UIImage(named: "tumeric")
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
