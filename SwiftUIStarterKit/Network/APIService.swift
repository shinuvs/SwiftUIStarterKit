//
//  APIService.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

protocol APIServiceProtocol {
    func fetch<T: Decodable>(from url: URL, shouldAuthenticate: Bool?, completion: @escaping (Result<T, APIError>) -> Void)
    func post<T: Encodable, U: Decodable>(to url: URL, body: T, shouldAuthenticate: Bool?, completion: @escaping (Result<U, APIError>) -> Void)
}

class APIService: APIServiceProtocol {
    
    private let timeoutInterval: TimeInterval = 30.0 // 30 seconds
    
    func fetch<T>(from url: URL, shouldAuthenticate: Bool? = false, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = timeoutInterval
        
        //Add authentication header
        if shouldAuthenticate ?? false {
            request.setValue(retrieveToken(), forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
    
    func post<T, U>(to url: URL, body: T, shouldAuthenticate: Bool? = true, completion: @escaping (Result<U, APIError>) -> Void) where T : Encodable, U : Decodable {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = timeoutInterval
        
        //Add authentication header
        if shouldAuthenticate ?? false {
            request.setValue(retrieveToken(), forHTTPHeaderField: "Authorization")
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.parsingFailed))
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
    
}

private extension APIService {
    
    func retrieveToken() -> String {
        "Get saved token from the source"
    }
    
    func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        if let error = error as? URLError {
            switch error.code {
            case .timedOut:
                completion(.failure(.timeout))
                return
            default:
                completion(.failure(.unknown))
            }
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.unknown))
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let apiError = APIError.mapStatusCode(httpResponse.statusCode)
            completion(.failure(apiError))
            return
        }
        
        guard let data = data else {
            completion(.failure(.unknown))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.parsingFailed))
        }
    }
}

