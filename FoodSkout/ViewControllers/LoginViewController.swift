//
//  LoginViewController.swift
//  FoodSkout
//
//  Created by Fernando on 12/11/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let defaults = UserDefaults.standard
    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        defaults.set(true, forKey: "saw_onboarding")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func performLogin(_ sender: UIButton) {
        
        guard let username = self.emailTextField.text,
            let password = self.passwordTextField.text else {
                return
        }
        
        let basicHeader = BasicAuth.generateBasicAuthHeader(username: username, password: password)
        keychain.set(basicHeader, forKey: "basicAuth")
        
        defaults.set(true, forKey: "isLoggedIn")
        Networking.instance.fetch(route: Route.user, method: "GET", data: nil) { (data, code)  in
            DispatchQueue.main.async {
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func performSignup(_ sender: UIButton) {
        
        guard let email = self.emailTextField.text,
            let password = self.passwordTextField.text else {
                return
        }
        
        let defaults = UserDefaults.standard
        
        let basicHeader = BasicAuth.generateBasicAuthHeader(username: email, password: password)
        let user = User(username: "El usuario", email: email, password: password)
        keychain.set(basicHeader, forKey: "basicAuth")
        defaults.set(true, forKey: "isLoggedIn")
        
        Networking.instance.fetch(route: Route.user, method: "POST", data: user) { (data, code) in
            
            DispatchQueue.main.async {
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }

}
