//
//  URLComponents+AppendParameters.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/28/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

extension URLComponents {
    init(service: Service) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .urlEncoding else { return }
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
