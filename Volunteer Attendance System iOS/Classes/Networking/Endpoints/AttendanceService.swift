//
//  AttendanceService.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/26/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public enum AttendanceService {
    case getAllLogs
    case createAttendanceEntry(notes: String)
    case finalizeAttendanceEntry(attendanceId: String)
    case deleteAttendanceEntry(attendanceId: String)
}

extension AttendanceService: Service {
    
    var baseURL: URL {
        return URL(string: "http://commandsapiname.azurewebsites.net/api/")!
    }
    
    var path: String {
        switch self {
        case .getAllLogs:
            return "Attendance"
        case .createAttendanceEntry(_):
            return "Attendance/signintime"
        case .finalizeAttendanceEntry(let attendanceId):
            return "Attendance/signout/\(attendanceId)"
        case .deleteAttendanceEntry(_):
            return "Attendance"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllLogs:
            return .get
        case .createAttendanceEntry(_):
            return .post
        case .finalizeAttendanceEntry(_):
            return .put
        case .deleteAttendanceEntry(_):
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllLogs:
            return .request
        case .createAttendanceEntry(let notes):
            let parameters = ["notes": notes]
            return .requestParameters(parameters)
        case .finalizeAttendanceEntry(let attendanceId):
            return .request
        case .deleteAttendanceEntry(let attendanceId):
        let parameters = ["attendanceid": attendanceId]
            return .requestParameters(parameters)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAllLogs, .createAttendanceEntry(_), .finalizeAttendanceEntry(_), .deleteAttendanceEntry(_):
            if let token = AppDelegate.keychain["gciUser"] {
                return ["Authorization": "Bearer \(token)"]
            } else {
                return nil
            }
        }
    }
    
    var parametersEncoding: ParameterEncoding {
        switch self {
        case .getAllLogs, .createAttendanceEntry(_):
            return .jsonEncoding
        case .finalizeAttendanceEntry(_), .deleteAttendanceEntry(_):
            return .urlEncoding
        }
    }
}
