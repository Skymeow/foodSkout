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
    
    @IBAction func gatstartedTapped(_ sender: UIButton) {
//        UserDefaults.standard.set("user", forKey: "name")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let navVC = storyboard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = navVC
//        appDelegate.window?.makeKeyAndVisible()
//        self.present(homeVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(homeVC, animated: true)
        let initialViewController = UIStoryboard.initialViewController(for: .login)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func animateViews() {
        
        let getStartedAnimation = {
            self.getStartedButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        
        UIView.animate(withDuration: 1.5, delay: 2, options: [.autoreverse, .repeat, .allowUserInteraction, .curveEaseInOut], animations: getStartedAnimation, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateViews()
    }
}
