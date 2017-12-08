//
//  StepTwo.swift
//  OnboardingForFoodSkout
//
//  Created by Sky Xu on 12/7/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

import UIKit
import CoreLocation

class StepTwo: UIViewController {
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    func animateViews() {
        
        let getStartedAnimation = {
            self.getStartedButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
//        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.5, delay: 2, options: [.autoreverse, .repeat, .allowUserInteraction, .curveEaseInOut], animations: getStartedAnimation, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateViews()
    }
}
