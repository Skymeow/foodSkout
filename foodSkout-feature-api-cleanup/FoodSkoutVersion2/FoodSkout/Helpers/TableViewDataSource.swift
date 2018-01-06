//
//  TableViewDataSource.swift
//  hippieFoodScrollView
//
//  Created by Sky Xu on 12/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

typealias tableCellCallback = (UITableView, IndexPath) -> UITableViewCell

class TableViewDataSource<Item>: NSObject, UITableViewDataSource {
    
    var configureCell: tableCellCallback?
    var items: [Item]
    init(items: [Item]) {
        self.items = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configureCell = configureCell else {
            precondition(false, "You didn't pass a configurecell closure to configurecell")
        }
        
        return configureCell(tableView, indexPath)
    }
    
}
