//
//  HTTPMethod.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 9/30/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

public struct HTTPMethod : RawRepresentable, Equatable, Hashable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static let get = HTTPMethod(rawValue: "GET")
    
    public static let post = HTTPMethod(rawValue: "POST")
    
    public static let put = HTTPMethod(rawValue: "PUT")
    
    public static let delete = HTTPMethod(rawValue: "DELETE")
    
}
