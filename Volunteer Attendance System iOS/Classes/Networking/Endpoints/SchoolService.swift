//
//  SchoolService.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/25/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public enum SchoolService {
    case allSchools
}

extension SchoolService: Service {
    
    var baseURL: URL {
        return URL(string: "http://commandsapiname.azurewebsites.net/api")!
    }
    
    var path: String {
        switch self {
        case .allSchools:
            return "/School"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allSchools:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .allSchools:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parametersEncoding: ParameterEncoding {
        return .urlEncoding
    }
}
