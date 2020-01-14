//
//  HomeCollectionViewCellType.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

enum HomeCollectionViewCellType {
    case timer
    case schoolInfo
    case meetingsInfo
    
    var getClass: BaseCollectionViewCell.Type {
        switch self {
        case .timer:
            return CheckInOutCollectionViewCell.self
        case .schoolInfo:
            return SchoolInfoCollectionViewCell.self
        case .meetingsInfo:
            return OutreachInfoCollectionViewCell.self
        }
    }
}
