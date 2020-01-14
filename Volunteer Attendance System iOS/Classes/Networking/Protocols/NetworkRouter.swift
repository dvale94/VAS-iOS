//
//  Router.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 9/30/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

protocol NetworkRouter {
    func request<T>(type: T.Type, _ route: Service, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}
