//
//  ChooseOrgansViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/28/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ChooseOrgansViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let organNames = ["brain", "heart", "liver", "stomach", "muscle", "thyroid", "lungs", "eye"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 )
        
        collectionView.collectionViewLayout = layout
    }
    
    
    // MARK: collection view relaid out
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ChooseOrgansViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "organCell", for: indexPath) as! OrganCollectionViewCell
        let row = indexPath.row
        let rowImg = UIImage(named: "Organ\(row)")!
        let organName = organNames[row]
        cell.configureCell(collectionImg: rowImg, organName: organName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumInteritemSpacing
        let insets = layout.sectionInset.left + layout.sectionInset.right
        
        let width = (collectionView.bounds.width * 0.5) - (insets + itemSpacing)
        
        return CGSize(width: width, height: collectionView.bounds.height * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = indexPath.row
        if let displayVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayOrganViewController") as? DisplayOrganViewController {
            present(displayVC, animated: true)
            displayVC.organName = organNames[row]
            displayVC.row = row
        }
        
    }
    
}


