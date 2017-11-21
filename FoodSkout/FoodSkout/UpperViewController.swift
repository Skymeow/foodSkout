//
//  UpperViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class UpperViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var upperView: UIView!
    
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        to make the extension have access to contentOffSet
        scrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let scrollWidth = scrollView.frame.size.width
        let scrollHeight = scrollView.frame.size.height
        let contentWidth = scrollWidth * 4
        let imgWidth = scrollWidth * 0.35
        let gapWidth = scrollWidth / 2 - imgWidth / 2
//        set the imgView to scrollView
        for n in 0...3 {
            let image = UIImage(named: "Organ\(n)")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            scrollView.addSubview(imageView)
            if n == 0 {
                imageView.frame = CGRect(x: CGFloat(n) * scrollWidth + gapWidth, y: scrollHeight * 0.28, width: imgWidth * 1.3, height: imgWidth * 1.3)
            } else {
                imageView.frame = CGRect(x: CGFloat(n) * scrollWidth + gapWidth, y: scrollHeight * 0.35, width: imgWidth, height: imgWidth)
            }
        }
        
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
    }
    
    /** animation makes the scrolled img bigger
     */
    func scrollMove(currentPage: Int) {
        UIScrollView.animate(withDuration: 0.4) {
            self.images[currentPage].transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            for x in 0..<self.images.count {
                if (x != currentPage && x != 0) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }
    
}

extension UpperViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let currentPage = 1 + abs((offset.x - scrollView.frame.size.width) / scrollView.frame.size.width)
        
        scrollMove(currentPage: Int(currentPage))
    }
}
