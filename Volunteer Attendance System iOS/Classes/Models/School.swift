//
//  School.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/25/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct School: Codable {
    let id, schoolid, name, address: String?
    let grade, phonenumber: String?
    let teams: [Team]?
    let schoolPersonnel: [SchoolPersonnel]?
}
