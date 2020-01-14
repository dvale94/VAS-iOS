//
//  UICollectionViewCell+CellReuseIdentifier.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    class var cellReuseIdentifier: String {
        return String(describing: self)
    }
}
