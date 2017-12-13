//
//  TagsCollectionDataSource.swift
//  FoodSkout
//
//  Created by Sky Xu on 12/12/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

typealias TagsCellCallback = (UICollectionView, IndexPath) -> UICollectionViewCell

class TagsCollectionDatasource<Item>: NSObject, UICollectionViewDataSource {
    var items: [Item]
    
    var configureCell: TagsCellCallback?
    
    init(items: [Item]) {
        self.items = items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let configureCell = configureCell else {
            precondition(false, "You did pass a configuration closure to configureCell, you must do so")
        }
        //We're going to set up the cell on another view controller, we'll set up the tableview data source, and type of cell in the viewdidload of the VC.
        return configureCell(collectionView, indexPath)
    }
}
