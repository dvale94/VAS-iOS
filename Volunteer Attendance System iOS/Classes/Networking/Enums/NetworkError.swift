//
//  NetworkError.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

public enum NetworkError : String, Error {
    case badRequest = "Bad request"
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unknownRequest = "Response could not be decoded."
    case dataDecodeFailure = "Data could not be decoded with given model."
}
