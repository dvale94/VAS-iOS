//
//  ValidationFactory.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/29/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var errMessage: String
    
    init(_ message: String) {
        self.errMessage = message
    }
}

protocol Validator {
    func validated(_ value: String) throws -> String
}

enum ValidationType {
    case password
    case requiredField(field: String)
}

enum ValidationFactory {
    
    static func validateFor(type: ValidationType) -> Validator {
        switch type {
        case .password:
            return PasswordValidator()
        case .requiredField(let field):
            return RequiredValidator(field)
        }
    }
    
}

struct PasswordValidator: Validator {
    func validated(_ value: String) throws -> String {
        guard value.isEmpty == false else {
            throw ValidationError("Password is Required")
        }
        
        do {
//            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{3,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                throw ValidationError("Password must be more than 3 characters")
//            }
            if try value.count <= 3 {
                throw ValidationError("Password must be more than 3 characters")
            }
        } catch {
            throw ValidationError("Password must be more than 3 characters")
        }
        
        return value
    }
}

struct RequiredValidator: Validator {
    
    private let field: String
    
    init(_ field: String) {
        self.field = field
    }
    
    func validated(_ value: String) throws -> String {
        guard value.isEmpty == false else {
            throw ValidationError("Required Field + \(field)")
        }
        
        return value
    }

}
