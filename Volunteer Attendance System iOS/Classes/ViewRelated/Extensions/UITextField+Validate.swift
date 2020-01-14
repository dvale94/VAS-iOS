//
//  UITextField+Validate.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/29/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

extension UITextField {
    func validate(_ type: ValidationType) throws -> String {
        let validator = ValidationFactory.validateFor(type: type)
        return try validator.validated(self.text ?? "")
    }
}
