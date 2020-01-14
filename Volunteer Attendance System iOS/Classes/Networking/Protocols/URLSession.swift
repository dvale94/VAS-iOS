//
//  URLSession.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/28/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

protocol SessionTask {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: SessionTask {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
