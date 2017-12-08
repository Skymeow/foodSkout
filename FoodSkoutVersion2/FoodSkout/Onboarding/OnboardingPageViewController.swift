//
//  OnboardingPageViewController.swift
//  OnboardingForFoodSkout
//
//  Created by Sky Xu on 12/7/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        dataSource = self
        delegate = self
        
        setViewControllers([getStepOne()], direction: .forward, animated: true, completion: nil)
    }
    
    func getStepOne() -> OrganToFoodViewController {
        return storyboard!.instantiateViewController(withIdentifier: "StepOne") as! OrganToFoodViewController
    }
    
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewController(withIdentifier: "StepTwo") as! StepTwo
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is StepTwo {
            // 2 -> 1
            return getStepOne()
        } else {
            
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is OrganToFoodViewController {
            // 1 -> 2
            return getStepTwo()
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPageViewController: UIPageViewControllerDelegate {}

