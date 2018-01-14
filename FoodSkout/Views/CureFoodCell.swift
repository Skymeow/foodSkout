//
//  CureFoodCell.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

protocol PassBuy: class {
    func actionSent(_ sender: CureFoodCell)
}
class CureFoodCell: UICollectionViewCell {
    
    weak var delegate: PassBuy?
    
    @IBOutlet weak var foodCureLabel: UILabel!
    @IBOutlet weak var foodCureImg: CustomImageView!
    
    @IBAction func buyTapped(_ sender: UIButton) {
        print("buy tapped")
        delegate?.actionSent(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
