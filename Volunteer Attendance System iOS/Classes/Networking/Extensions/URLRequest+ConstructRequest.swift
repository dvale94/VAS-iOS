//
//  URLRequest+ConstructRequest.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/28/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

extension URLRequest {
    init(service: Service) {
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!)
        httpMethod = service.httpMethod.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        if self.value(forHTTPHeaderField: "Content-Type") == nil {
            self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .jsonEncoding else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
