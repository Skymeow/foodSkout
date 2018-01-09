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
    
    @IBOutlet weak var cureImg: UIImageView!
    @IBOutlet weak var causeContext: UILabel!
    @IBOutlet weak var diseaseName: UILabel!
    weak var delegate: passCureDelegate?
    
    @IBAction func cureTapped(_ sender: UIButton) {
        print("cure food tapped")
        delegate?.tappedCure(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
