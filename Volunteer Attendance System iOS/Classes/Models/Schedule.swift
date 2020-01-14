//
//  Schedule.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/28/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    let applicationUserID: String?
    let applicationUser: Volunteer?
    let schoolID: String?
    let school: School?
    let dayofweekID: Int?
    let createdby, starttime, endtime, classize: String?
    let comments: String?

    enum CodingKeys: String, CodingKey {
        case applicationUserID = "applicationUserId"
        case applicationUser
        case schoolID = "schoolId"
        case school
        case dayofweekID = "dayofweekId"
        case createdby, starttime, endtime, classize, comments
    }
}


public struct CreateSchool: Codable {
    let schoolid, userid: String?
    let dayoftheweek: Int?
    let startime, endtime, classize, comments: String?
}
