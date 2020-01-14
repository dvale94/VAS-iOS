//
//  NetworkResult.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 9/30/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

public enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
    case empty
}
