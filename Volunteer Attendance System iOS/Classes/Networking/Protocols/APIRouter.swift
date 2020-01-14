//
//  APIRouter.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 10/1/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

class APIRouter: NetworkRouter {
    
    private var urlSession = URLSession.shared
    private var session: SessionTask?
    
    init(session: SessionTask = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, _ service: Service, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)
        if let session = self.session {
            let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
                let httpResponse = response as? HTTPURLResponse
                self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
            })
            task.resume()
        }
    }
}

// MARK: - URL Request Configuration Helpers
extension APIRouter {
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> Void) {
        guard error == nil else { return completion(.failure(.unknownRequest)) }
        guard let response = response else { return completion(.failure(.noData)) }
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(.dataDecodeFailure)) }
            return completion(.success(model))
        case 501...599:
            return completion(.failure(.badRequest))
        default:
            return completion(.failure(.unknownRequest))
        }
    }
}
