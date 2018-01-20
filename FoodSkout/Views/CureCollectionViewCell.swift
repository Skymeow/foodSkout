//
//  CureCollectionViewCell.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/21/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

protocol passCureDelegate: class {
    func tappedCure(_ sender: CureCollectionViewCell)
}

class CureCollectionViewCell: UICollectionViewCell {
    var goodCurefood: [Food]?
    @IBOutlet weak var cureImg: CustomImageView!
    @IBOutlet weak var causeContext: UILabel!
    @IBOutlet weak var diseaseName: UILabel!
    weak var delegate: passCureDelegate?
    
    @IBAction func cureTapped(_ sender: UIButton) {
        delegate?.tappedCure(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
