//
//  BaseCollectionViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    var cellTypes = [HomeCollectionViewCellType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellTypes.count == 0 {
            collectionView.setEmptyMessage("Welcome! Check back in to see if you've been matched.")
        } else {
            collectionView.restore()
        }
        return cellTypes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = cellTypes[indexPath.row]
        let cellClass = c.getClass
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.cellReuseIdentifier, for: indexPath)
        
        return cell
    }
    
}
