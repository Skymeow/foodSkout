//
//  OrganViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/19/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class OrganViewController: UIViewController {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()
//    we have 4 pics for now
    let maxPage = 3
    let minPage = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        let scrollWidth = scrollView.frame.size.width
        
        for x in 0...3 {
            let image = UIImage(named: "Organ\(x)")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var nextX: CGFloat = 0.0
            nextX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            contentWidth += nextX
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: nextX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 120, height: 120)
        }
        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: upperView.frame.size.height)
    }
    
    /** set scrolling view point and create animation to increse scrolled img while revert the size of non-active img view
 */
    func scrollMove(direction: Int) {
        currentPage += direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        UIScrollView.animate(withDuration: 0.4) {
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    @IBAction func slideToRight(_ sender: UISwipeGestureRecognizer) {
        if (currentPage < maxPage) {
            scrollMove(direction: 1)
        }
    }
    
    
    @IBAction func slideToLeft(_ sender: UISwipeGestureRecognizer) {
        if (currentPage > minPage) {
            scrollMove(direction: -1)
        }
    }
    
}
