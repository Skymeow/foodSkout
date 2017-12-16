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
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = 2
        self.pageControl.currentPage = 0
        // self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
        //        let pageControl = UIPageControl.appearance()
        //        pageControl.pageIndicatorTintColor = UIColor.lightGray
        //        pageControl.currentPageIndicatorTintColor = UIColor.red
        //        pageControl.backgroundColor = UIColor.blue
    }
    
    func getStepOne() -> OrganToFoodViewController {
        return storyboard!.instantiateViewController(withIdentifier: "StepOne") as! OrganToFoodViewController
    }
    
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewController(withIdentifier: "StepTwo") as! StepTwo
    }
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.getStepOne(), self.getStepTwo()]
    }()
    
//    override open func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        for subV in self.view.subviews {
//            if type(of: subV).description() == "UIPageControl" {
//                let pos = CGPoint(x: 0, y: (UIScreen.main.bounds.maxY - 50))
//                subV.frame = CGRect(origin: pos, size: subV.frame.size)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        dataSource = self
        delegate = self
        // MARK: ???
        setViewControllers([orderedViewControllers[0]], direction: .forward, animated: true, completion: nil)
        configurePageControl()
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // MARK: ???
        
        if viewController is StepTwo {
            // 2 -> 1
            return orderedViewControllers[0]  // getStepOne() // <- Shouldn't make new one!
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is OrganToFoodViewController {
            // 1 -> 2
            return orderedViewControllers[1]
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // MARK: ????
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPageViewController: UIPageViewControllerDelegate {}

