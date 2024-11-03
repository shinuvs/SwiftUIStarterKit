//
//  APIError.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

enum APIError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalError
    case serviceUnavailable
    case parsingFailed
    case urlEncodingFailed
    case timeout
    case unknown
    
    static func mapStatusCode(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500:
            return .internalError
        case 503:
            return .serviceUnavailable
        default:
            return .unknown
        }
    }
}
