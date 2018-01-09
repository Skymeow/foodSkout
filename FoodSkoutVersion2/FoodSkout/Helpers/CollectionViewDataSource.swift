//
//  collectionDataSource.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

typealias cellCallback = (UICollectionView, IndexPath) -> UICollectionViewCell

class CollectionViewDataSource<Item>: NSObject, UICollectionViewDataSource {
    var items: [Item]
    var configureCell: cellCallback?
    
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
            precondition(false, "You didn't pass a configurecell closure to configurecell")
        }
        
        return configureCell(collectionView, indexPath)
    }
}
