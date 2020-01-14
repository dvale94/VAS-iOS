//
//  Credentials.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/19/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

class Credentials {
    
    var email: String = ""
    var password: String = ""
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
    
}
