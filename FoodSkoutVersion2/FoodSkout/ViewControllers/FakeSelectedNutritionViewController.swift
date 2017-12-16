//
//  FakeSelectedNutritionViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/14/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class FakeSelectedNutritionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = TagsCollectionDatasource(items: [])
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.dataSource.items = ["LOW_CARB", "LOW_SUGAR", "GLUTEN_FREE", "TREE_NUT_FREE", "CRUSTACEAN_FREE"]
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        let tagCell = UINib(nibName: "TagsCell", bundle: Bundle.main)
        collectionView.register(tagCell, forCellWithReuseIdentifier: "TagsCell")
        dataSource.configureCell = { (collectionView, indexPath) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
                cell.label.text = ["LOW_CARB", "LOW_SUGAR", "GLUTEN_FREE", "TREE_NUT_FREE", "CRUSTACEAN_FREE"][indexPath.row]
            return cell
        }
    }
}

extension FakeSelectedNutritionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 45)
    }
}

