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
    @IBOutlet weak var searchButton: UIButton!
  
    var images = [UIImageView]()
    let organNames = ["brain", "heart", "liver", "stomach", "muscle", "thyroid", "lungs", "eye"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        to make the extension have access to contentOffSet
        scrollView.delegate = self
        self.searchButton.backgroundColor = UIColor.lightGray
        self.searchButton.setTitleColor(UIColor.gray, for: .normal)
    }
    
  @IBAction func searchButtonTapped(_ sender: UIButton) {
    
  }
  override func viewDidAppear(_ animated: Bool) {
        let scrollWidth = scrollView.frame.size.width
        let scrollHeight = scrollView.frame.size.height
        let contentWidth = scrollWidth * 8
        setImg(n: 7, scrollWidth: scrollWidth, scrollHeight: scrollHeight)
        self.scrollView.contentSize = CGSize(width: contentWidth, height: scrollHeight)
        }
  /** Set organ imgs and dot position */
    func setImg(n: Int, scrollWidth: CGFloat, scrollHeight: CGFloat) {
      for n in 0...7 {
        let image = UIImage(named: "Organ\(n)")
        let imageView = UIImageView(image: image)
        self.images.append(imageView)
        self.scrollView.addSubview(imageView)
        let imgWidth = scrollWidth * 0.25
        let gapWidth = scrollWidth / 2 - imgWidth / 2
        imageView.frame = CGRect(x: CGFloat(n) * scrollWidth + gapWidth, y: scrollHeight * 0.35, width: imgWidth, height: imgWidth)
  
        let topLabel = UILabel()
        topLabel.frame = CGRect(x: CGFloat(n) * scrollWidth + gapWidth + (imgWidth - 85) * 0.5, y: scrollHeight * 0.14, width: 85, height: 25)
        topLabel.text = organNames[n]
        topLabel.textAlignment = .center
        topLabel.textColor = UIColor.white
        topLabel.font = UIFont.systemFont(ofSize: 20)
        self.scrollView.addSubview(topLabel)
     
      }
    }
    
    /** animation makes the scrolled img bigger
     */
  func scrollMove(progress: CGFloat) {
        UIScrollView.animate(withDuration: 0.4) {
            self.searchButton.backgroundColor = UIColor.lightGray
            self.searchButton.setTitleColor(UIColor.gray, for: .normal)
          
            for x in -1..<self.images.count {
                if (progress > CGFloat(x) && CGFloat(x) < CGFloat(x) + 1) {
                    self.searchButton.backgroundColor = UIColor(red:0.90, green:0.89, blue:0.58, alpha:1.0)
                    self.searchButton.setTitleColor(UIColor.white, for: .normal)
                }
            }
        }
    }
    
}

extension UpperViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let scrollProgress = CGFloat((offset.x - scrollView.frame.size.width) / scrollView.frame.size.width) + 1
        scrollMove(progress: scrollProgress)
        self.generateFeedback()
    }
}

extension UpperViewController {
    public func generateFeedback(){
        /// Generates feedback "selectionChanged" feedback
        if #available(iOS 10.0, *) {
            let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            heavyImpactFeedbackGenerator.impactOccurred()
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.prepare()
            feedbackGenerator.selectionChanged()
            feedbackGenerator.prepare()
        }
    }
}
