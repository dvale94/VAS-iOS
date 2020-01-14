//
//  NetworkManager.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/13/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import KeychainAccess

struct NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    private let keychain = Keychain(server: "http://commandsapiname.azurewebsites.net/api/", protocolType: .http)
    private let router = APIRouter()
    
    // MARK: - User Registration
    func registerUser(_ user: User, completion: @escaping (_ user: Volunteer?, _ error: String?) -> Void) {
    }
    
    // MARK: - User Login
    func loginUser(username: String, password: String, completion: @escaping (_ user: Volunteer?, _ error: String?) -> Void) {
        router.request(type: Token.self, LoginService.login(username: username, password: password)) { response in
            switch response {
            case .success(let data):
                self.keychain["gciUser"] = data.token
                self.authenticateUser(with: data.token, completion: completion)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, nil)
            }
        }
    }
    
    fileprivate func authenticateUser(with token: String, completion: @escaping (_ user: Volunteer?, _ error: String?) -> Void) {
        router.request(type: UserProfile.self, LoginService.userExists(withToken: token)) { response in
            switch response {
            case .success(let data):
                print(data)
                if data.strRole?.lowercased() == "admin" {
                    UserDefaults.standard.set(true, forKey: "isUserAdmin")
                }
                self.getUserProfile(with: data.email ?? "", completion: completion)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    fileprivate func getUserProfile(with email: String, completion: @escaping (_ user: Volunteer?, _ error: String?) -> Void) {
        getAllUsers { users, error in
            if let users = users {
                users.forEach { user in
                    if user.email == email {
                        completion(user, nil)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Retreive All Users
    func getAllUsers(completion: @escaping (_ user: [Volunteer]?, _ error: String?) -> Void) {
        router.request(type: [Volunteer].self, UserService.getAllUsers) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    // MARK: - Attendance Related
    func getAllAttendanceLogs(completion: @escaping (_ attendanceLog: UserAttendance?, _ error: String?) -> Void) {
        router.request(type: UserAttendance.self, AttendanceService.getAllLogs) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    func signIn(completion: @escaping (_ attendanceEntryId: String?, _ error: String?) -> Void) {
        router.request(type: Attendance.self, AttendanceService.createAttendanceEntry(notes: "TBA")) { response in
            switch response {
            case .success(let data):
                completion(data.id, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    func signOut(for attendanceId: String, completion: @escaping (_ wasSuccessful: Bool?, _ error: String?) -> Void) {
        router.request(type: Attendance.self, AttendanceService.finalizeAttendanceEntry(attendanceId: attendanceId)) { response in
            switch response {
            case .success(_):
                completion(true, nil)
            case .failure(let error):
                completion(false, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    func deleteAttendanceEntry(for attendanceId: String, completion: @escaping (_ successful: Bool?, _ error: String?) -> Void) {
        router.request(type: UserAttendance.self, AttendanceService.deleteAttendanceEntry(attendanceId: attendanceId)) { response in
            switch response {
            case .success(_):
                completion(true, nil)
            case .failure(let error):
                completion(false, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    // MARK: - Scheduling Related
    func getScheduleForUser(with email: String, completion: @escaping(_ schedule: Schedule?, _ error: String?) -> Void) {
        getAllSchedules { schedules, error in
            if let schedules = schedules {
                schedules.forEach { schedule in
                    if schedule.applicationUser?.email == email {
                        completion(schedule, nil)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getAllSchedules(completion: @escaping (_ schedules: [Schedule]?, _ error: String?) -> Void) {
        router.request(type: [Schedule].self, ScheduleService.getAllSchedules) { response in
            switch response {
            case .success(let schedules):
                completion(schedules, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    // MARK: - School Related
    func getAllSchools(completion: @escaping (_ schools: [School]?, _ error: String?) -> Void) {
        router.request(type: [School].self, SchoolService.allSchools) { response in
            switch response {
            case .success(let schools):
                completion(schools, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            case .empty:
                completion(nil, NetworkError.failed.rawValue)
            }
        }
    }
    
    func createSchool(_ school: School) {
        
    }
    
}
