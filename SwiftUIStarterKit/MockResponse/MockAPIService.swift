//
//  MockAPIService.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-11-03.
//

import Foundation


class MockAPIService: APIServiceProtocol {
    
    var shouldReturnError = false
    var shouldReturnMalformedURL = false
    var responseToReturn: Any? // This will hold the products or any other response
    
    func fetch<T>(from url: URL, shouldAuthenticate: Bool?, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        if shouldReturnMalformedURL {
            completion(.failure(.urlEncodingFailed)) // Simulate a URL encoding failure
        } else if shouldReturnError {
            completion(.failure(.unknown)) // Simulate a generic error
        } else {
            // Ensure responseToReturn is castable to T
            if let response = responseToReturn as? T {
                completion(.success(response))
            } else {
                completion(.failure(.parsingFailed)) // Handle parsing failure
            }
        }
    }
    
    func post<T, U>(to url: URL, body: T, shouldAuthenticate: Bool?, completion: @escaping (Result<U, APIError>) -> Void) where T : Encodable, U : Decodable {
        if shouldReturnMalformedURL {
            completion(.failure(.urlEncodingFailed)) // Simulate a URL encoding failure
        } else if shouldReturnError {
            completion(.failure(.unknown)) // Simulate a generic error
        } else {
            if let response = responseToReturn as? U {
                completion(.success(response))
            } else {
                completion(.failure(.parsingFailed)) // Handle parsing failure
            }
        }
    }
}
