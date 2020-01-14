//
//  Attendance.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/26/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct UserAttendance: Codable {
    let id, pantherNo, email, userName: String?
    let attendances: [Attendance]?
}

// MARK: - Attendance
struct Attendance: Codable {
    let id, pantherid, date, signInTime: String?
    let signOutTime: String?
    let notes: String?
}
