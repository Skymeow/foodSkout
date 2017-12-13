//
//  LowerTableViewCell.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class LowerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: CustomImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layerWillDraw(_ layer: CALayer) {
        imgView.layer.cornerRadius = imgView.frame.width / 2
        imgView.layer.masksToBounds = false
        imgView.clipsToBounds = true
    }
    
    
    func configureCell() {
        
    }
    //  lowerTableViewCell.imgView.layer.cornerRadius = lowerTableViewCell.imgView.frame.height / 2
    //  lowerTableViewCell.imgView.layer.masksToBounds = false
    //  lowerTableViewCell.imgView.clipsToBounds = true
}
