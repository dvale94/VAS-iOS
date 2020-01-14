//
//  GCIService.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/6/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public enum LoginService {
    case register(user: User)
    case login(username: String, password: String)
    case userExists(withToken: String)
}

extension LoginService: Service {
    
    var baseURL: URL {
        return URL(string: "http://commandsapiname.azurewebsites.net/api")!
    }
    
    var path: String {
        switch self {
        case .register(_):
            return "/ApplicationUser/Register"
        case .login:
            return "/ApplicationUser/Login"
        case .userExists(_):
            return "/UserProfile"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register(_):
            return .post
        case .login(_, _):
            return .post
        case .userExists(_):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .register(let user):
            let parameters = ["userName": user.userName, "email": user.email,
                              "password": user.password, "pantherNo": user.pantherNo,
                              "role": user.role]
            return .requestParameters(parameters)
        case .login(let username, let password):
            let parameters = ["UserName": username, "Password": password]
            return .requestParameters(parameters)
        case .userExists(_):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .register(_), .login(_, _):
            return nil
        case .userExists(let withToken):
            let bearerToken = ["Authorization": "Bearer \(withToken)"]
            return bearerToken
        }
    }
    
    var parametersEncoding: ParameterEncoding {
        return .jsonEncoding
    }
    
    
}
