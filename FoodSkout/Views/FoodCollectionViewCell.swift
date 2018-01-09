//
//  FoodCollectionViewCell.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

protocol passButtonDelegate: class {
    func tapped(_ sender: FoodCollectionViewCell)
}
class FoodCollectionViewCell: UICollectionViewCell {
    
    var superFoodName: String?
    weak var delegate: passButtonDelegate?
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodOfDayImg: UIImageView!
    @IBOutlet weak var foodOfDayLabel: UILabel!
    
    @IBAction func recipeTapped(_ sender: UIButton) {
        delegate?.tapped(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
