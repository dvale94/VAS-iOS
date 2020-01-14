//
//  Team.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/25/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct Team: Codable {
    let id, teamnumber, teamDescription: String?
    let volunteer: [Volunteer]?

    enum CodingKeys: String, CodingKey {
        case id, teamnumber
        case teamDescription = "description"
        case volunteer
    }
}
