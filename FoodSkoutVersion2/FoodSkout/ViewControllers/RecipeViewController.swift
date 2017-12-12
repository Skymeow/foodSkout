//
//  RecipeViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/11/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var foodName: String?
    
    var recipeData: [Recipes]?
    
    @IBOutlet weak var recipeImg: UIImageView!
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLayoutSubviews() {
        let scrollViewBounds = scrollView.bounds
        let contentViewBounds = contentView.bounds
        
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height
        scrollViewInsets.top -= contentViewBounds.size.height
        
        scrollViewInsets.bottom = scrollViewBounds.size.height
        scrollViewInsets.bottom -= contentViewBounds.size.height
        scrollViewInsets.bottom += 1
        
        scrollView.contentInset = scrollViewInsets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
