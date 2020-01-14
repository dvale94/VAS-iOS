//
//  UserService.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/27/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public enum UserService {
    case getAllUsers
}

extension UserService: Service {
    
    var baseURL: URL {
        return URL(string: "http://commandsapiname.azurewebsites.net/api/UserProfile")!
    }
    
    var path: String {
        switch self {
        case .getAllUsers:
            return "/all"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllUsers:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllUsers:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parametersEncoding: ParameterEncoding {
        return .jsonEncoding
    }
}
