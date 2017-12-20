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
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func gatstartedTapped(_ sender: UIButton) {
        let initialViewController = UIStoryboard.initialViewController(for: .login)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func animateViews() {
        
        let getStartedAnimation = {
            self.getStartedButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        
        stackView.axis = . horizontal
        let animation = {
            self.stackView.axis = .vertical
            self.textLabel.alpha = 1
        }
        self.textLabel.alpha = 0
        
        ThrottleHelper.throttle(seconds: 0.4) {
            UIView.animate(withDuration: 1.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity:0.7, options: .curveEaseInOut, animations: animation, completion: nil)
        }
        
        UIView.animate(withDuration: 1.5, delay: 2, options: [.autoreverse, .repeat, .allowUserInteraction, .curveEaseInOut], animations: getStartedAnimation, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateViews()
    }
}
