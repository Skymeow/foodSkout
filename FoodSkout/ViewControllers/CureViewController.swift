//
//  CureViewController.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class CureViewController: UIViewController {
    
    var cureFoods = ["tumeric", "cucumber", "carrots", "chips", "jazz", "othershit"]
    var dataSource = CollectionViewDataSource(items: [])
    
    @IBOutlet weak var diseaseImgView: UIImageView!
    @IBOutlet weak var cureFoodCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        cureFoodCollectionView.dataSource = self.dataSource
        dataSource.items = cureFoods
        cureFoodCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cureFoodCollectionView.delegate = self
        let cell = UINib(nibName: "CureFoodCell", bundle: Bundle.main)
        cureFoodCollectionView.register(cell, forCellWithReuseIdentifier: "cureFoodCell")
        dataSource.configureCell = {(cureFoodCollectionView, indexPath) -> UICollectionViewCell in
            let cell = cureFoodCollectionView.dequeueReusableCell(withReuseIdentifier: "cureFoodCell", for: indexPath) as! CureFoodCell
            cell.foodCureLabel.text = self.cureFoods[indexPath.row]
            
            return cell
        }
    }
}
extension CureViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumInteritemSpacing
        let insets = layout.sectionInset.left + layout.sectionInset.right
        let width = (collectionView.bounds.size.width * 0.5) - (insets + itemSpacing)
        let height = collectionView.bounds.size.height * 0.3
        
        return CGSize(width: width, height: height)
    }
}
