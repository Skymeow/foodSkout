 //
//  ViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, passButtonDelegate, passCureDelegate {
    
    var checkIfSuperfoodLoaded: Bool = false
    var checkIfCurefoodLoaded: Bool = false
    var foodDayLabelData: [Superfood]?
    var cureLabelData: [Foodcure]?
    let dataSource1 = CollectionViewDataSource(items: [])
    let dataSource2 = CollectionViewDataSource(items: [])
    let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
    let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var cureCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var exploreButton: UIButton!
    
    // MARK: View lifecycle methods here
    
    @IBAction func exploreTapped(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func showLoadingAlert() {
        self.spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        self.spinnerIndicator.color = UIColor.black
        self.spinnerIndicator.startAnimating()
        self.alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
    }
    
    func killLoadingAlert() {
        self.alertController.dismiss(animated: true, completion: nil)
    }
    
    func tapped(_ sender: FoodCollectionViewCell) {
        let superFoodName = sender.foodNameLabel.text
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let superRecipeVC = storyBoard.instantiateViewController(withIdentifier: "superVC") as! SuperfoodViewController
        superRecipeVC.superFoodName = superFoodName
        self.navigationController?.pushViewController(superRecipeVC, animated: true)
    }
    
    func tappedCure(_ sender: CureCollectionViewCell) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let cureVC = storyBoard.instantiateViewController(withIdentifier: "cureVC") as! CureViewController
        cureVC.goodCurefood = sender.goodCurefood
        //MARK: let dataSource = CollectionViewDataSource(items: sender.goodCurefood)
        cureVC.diseaseImg = sender.cureImg

        self.navigationController?.pushViewController(cureVC, animated: true)
    }
    
    func animateButton() {
        let exploreAnimate = { self.exploreButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        
        UIView.animate(withDuration: 1.5, delay: 2, options: [.autoreverse, .repeat, .allowUserInteraction, .curveEaseInOut], animations: exploreAnimate, completion: nil)
    }
    
    func getSuperfoodData(completion: @escaping(Bool) -> Void) {
        Networking.instance.fetch(route: .superfood, method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode([Superfood].self, from: data)
                guard let results = result else { return }
                self.foodDayLabelData = results
                self.checkIfSuperfoodLoaded = true
                completion(true)
            }
        }
    }
    
    func getCurefoodData(completion: @escaping(Bool) -> Void) {
        Networking.instance.fetch(route: .foodcure, method: "GET", data: nil) { (data, response) in
            if response == 200 {
                let result = try? JSONDecoder().decode([Foodcure].self, from: data)
                guard let results = result else { return }
                self.cureLabelData = results
                self.checkIfCurefoodLoaded = true
                completion(true)
            }
        }
    }
    
    func assignlabel(_ label1: UILabel, _ label2: UILabel, _ str1: String, _ str2: String) {
        DispatchQueue.main.async {
            label1.text = str1
            label2.text = str2
        }
    }
    
    override func viewDidLayoutSubviews() {
        // MARK: Can remove this code since we set "Bounce Vertically"
        //       on the scrollview. This property is .alwaysBouncesVertically
//        let scrollBounds = self.scrollView.bounds
//        let contentBounds = self.contentView.bounds
//        var scrollViewInsets = UIEdgeInsets.zero
//        scrollViewInsets.top = scrollBounds.size.height
//        scrollViewInsets.top -= contentBounds.size.height
//        scrollViewInsets.bottom = scrollBounds.size.height
//        scrollViewInsets.bottom -= contentBounds.size.height
//        scrollViewInsets.bottom += 1
//        
//        scrollView.contentInset = scrollViewInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.animateButton()
        getSuperfoodData{ (success) in
            if success {
                DispatchQueue.main.async {
                    self.dataSource1.items = self.foodDayLabelData!
                    self.foodCollectionView.dataSource = self.dataSource1
                    self.foodCollectionView.reloadData()
                }
            }
        }
        
        getCurefoodData{ (success) in
            if success {
                DispatchQueue.main.async {
                    self.dataSource2.items = self.cureLabelData!
                    self.cureCollectionView.dataSource = self.dataSource2
                    self.cureCollectionView.reloadData()
                    self.killLoadingAlert()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "saw_onboarding")
        if self.checkIfSuperfoodLoaded == false && self.checkIfCurefoodLoaded == false{
            showLoadingAlert()
        }

        
        foodCollectionView.delegate = self
        // MARK: foodCollectionView.dataSource = dataSource1
        
        let foodCell = UINib(nibName: "FoodCollectionViewCell", bundle: Bundle.main)
        foodCollectionView.register(foodCell, forCellWithReuseIdentifier: "foodCell")
        dataSource1.configureCell = {(foodCollectionView, indexPath) -> UICollectionViewCell in
            let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
            cell.delegate = self
            let superfoodStr = self.foodDayLabelData![indexPath.row].img
            cell.foodOfDayImg.loadImageFromUrlString(urlString: superfoodStr)
            self.assignlabel(cell.foodNameLabel, cell.foodOfDayLabel, self.foodDayLabelData![indexPath.row].superfood_name, self.foodDayLabelData![indexPath.row].description)
            
            return cell
        }
        
        cureCollectionView.delegate = self
        let cureCell = UINib(nibName: "CureCollectionViewCell", bundle: Bundle.main)
        cureCollectionView.register(cureCell, forCellWithReuseIdentifier: "cureCell")
        dataSource2.configureCell = {(CureCollectionView, indexPath) -> UICollectionViewCell in
            let cell = self.cureCollectionView.dequeueReusableCell(withReuseIdentifier: "cureCell", for: indexPath) as! CureCollectionViewCell
            cell.delegate = self
            cell.goodCurefood = self.cureLabelData![indexPath.row].goodFood
            let curefoodStr = self.cureLabelData![indexPath.row].img
            cell.cureImg.loadImageFromUrlString(urlString: curefoodStr)
            self.assignlabel(cell.diseaseName, cell.causeContext, self.cureLabelData![indexPath.row].cureName, self.cureLabelData![indexPath.row].detail)
            
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
 
