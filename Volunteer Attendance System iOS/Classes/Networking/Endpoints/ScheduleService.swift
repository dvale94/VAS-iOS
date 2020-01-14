//
//  ScheduleService.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/29/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public enum ScheduleService {
    case createSchedule(school: CreateSchool)
    case getAllSchedules
    case updateSchedule(school: CreateSchool)
    case deleteSchedule(userId: String, schoolId: String, dayId: Int)
}

extension ScheduleService: Service {
    
    var baseURL: URL {
        return URL(string: "http://commandsapiname.azurewebsites.net/api/")!
    }
    
    var path: String {
        switch self {
        case .getAllSchedules:
            return "Schedule"
        case .createSchedule(_):
            return "Schedule/create"
        case .updateSchedule(_):
            return "Schedule"
        case .deleteSchedule(_):
            return "Schedule"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllSchedules:
            return .get
        case .createSchedule(let school):
            return .post
        case .updateSchedule:
            return .put
        case .deleteSchedule(let userId, let schoolId, let dayId):
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllSchedules:
            return .request
        case .createSchedule(let school):
            let parameters = ["schoolid": school.schoolid, "userid": school.userid,
                              "dayoftheweek": school.dayoftheweek, "startime": school.startime,
                              "endtime": school.endtime, "classsize": school.classize,
                              "comments": school.comments] as [String : Any]
            return .requestParameters(parameters)
        case .updateSchedule(let school):
            let parameters = ["schoolid": school.schoolid, "userid": school.userid,
                              "dayoftheweek": school.dayoftheweek, "startime": school.startime,
                              "endtime": school.endtime, "classsize": school.classize,
                              "comments": school.comments] as [String : Any]
            return .requestParameters(parameters)
        case .deleteSchedule(let userId, let schoolId, let dayId):
            let parameters = ["userid": userId, "schoolid": schoolId, "dayid": dayId] as [String : Any]
            return .requestParameters(parameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parametersEncoding: ParameterEncoding {
        return .jsonEncoding
    }
}
