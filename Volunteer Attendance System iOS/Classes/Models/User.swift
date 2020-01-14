//
//  User.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/26/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public struct User: Codable {
    let userName, email, password, pantherNo: String?
    let role: String?
}
