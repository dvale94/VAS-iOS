//
//  Volunteer.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/25/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct Volunteer: Codable, Equatable {
    let id, userName, email, pantherNo: String?
    let firstname, lastname, position, major: String?
    let caravailable: Bool?
    let currentstatus: String?
    let mdcpsid: Int?
}

extension Volunteer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
