 //
//  ViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, passButtonDelegate, passCureDelegate {
    
    var foodDayLabelData = ["Açai", "Goji Berries", "Cacao"]
    var cureLabelData = ["Fight Fatigue", "Reduce Migraines", "Fight Cramps"]
    var foodImgData: [String]?
    let dataSource1 = CollectionViewDataSource(items: [])
    let dataSource2 = CollectionViewDataSource(items: [])
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var cureCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var exploreButton: UIButton!
    
    func tapped(_ sender: FoodCollectionViewCell) {
        let superFoodName = sender.superFoodName
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let superRecipeVC = storyBoard.instantiateViewController(withIdentifier: "superVC") as! SuperfoodViewController
        superRecipeVC.superFoodName = superFoodName
        self.navigationController?.pushViewController(superRecipeVC, animated: true)
    }
    
    func tappedCure(_ sender: CureCollectionViewCell) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let cureVC = storyBoard.instantiateViewController(withIdentifier: "cureVC") as! CureViewController
        self.navigationController?.pushViewController(cureVC, animated: true)
    }
    
    func animateButton() {
        let exploreAnimate = { self.exploreButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        
        UIView.animate(withDuration: 1.5, delay: 2, options: [.autoreverse, .repeat, .allowUserInteraction, .curveEaseInOut], animations: exploreAnimate, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        let scrollBounds = self.scrollView.bounds
        let contentBounds = self.contentView.bounds
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollBounds.size.height
        scrollViewInsets.top -= contentBounds.size.height
        scrollViewInsets.bottom = scrollBounds.size.height
        scrollViewInsets.bottom -= contentBounds.size.height
        scrollViewInsets.bottom += 1
        
        scrollView.contentInset = scrollViewInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.animateButton()
        self.dataSource1.items = self.foodDayLabelData
        self.foodCollectionView.dataSource = self.dataSource1
        self.foodCollectionView.reloadData()
        
        self.dataSource2.items = self.cureLabelData
        self.cureCollectionView.dataSource = self.dataSource2
        self.cureCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodCollectionView.delegate = self
        let foodCell = UINib(nibName: "FoodCollectionViewCell", bundle: Bundle.main)
        foodCollectionView.register(foodCell, forCellWithReuseIdentifier: "foodCell")
        dataSource1.configureCell = {(foodCollectionView, indexPath) -> UICollectionViewCell in
            let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
            cell.delegate = self
            cell.foodNameLabel.text = self.foodDayLabelData[indexPath.row]
            cell.foodNameLabel.adjustsFontSizeToFitWidth = true
            
            return cell
        }
        
        cureCollectionView.delegate = self
        let cureCell = UINib(nibName: "CureCollectionViewCell", bundle: Bundle.main)
        cureCollectionView.register(cureCell, forCellWithReuseIdentifier: "cureCell")
        dataSource2.configureCell = {(CureCollectionView, indexPath) -> UICollectionViewCell in
            let cell = self.cureCollectionView.dequeueReusableCell(withReuseIdentifier: "cureCell", for: indexPath) as! CureCollectionViewCell
            cell.delegate = self
            cell.diseaseName.text = self.cureLabelData[indexPath.row]
            cell.diseaseName.adjustsFontSizeToFitWidth = true
            
            return cell
        }
    }
 }
 
 extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.foodCollectionView.bounds.size.height
        return CGSize(width: 320, height: height)
    }
 }
 
