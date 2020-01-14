//
//  UICollectionView+RegisterCellClass.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCellClass(_ cellClass: UICollectionViewCell.Type) {
        let cellReuseIdentifier = cellClass.cellReuseIdentifier
        register(cellClass.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
}
