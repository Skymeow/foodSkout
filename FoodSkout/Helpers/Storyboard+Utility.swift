//
//  Storyboard+Utility.swift
//  Trip Planner
//
//  Created by Fernando on 10/28/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum StoryboardType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: StoryboardType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: StoryboardType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}

