//
//  APIEndPoint.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

enum ApiEndPoint {
    case login
    case products
    case product(productId: String)
    
    var environment: APIEnvironment {
        return .development // Change this to your desired enviorment
    }
    
    var apiURL: URL? {
        let baseUrl = environment.baseUrl
        switch self {
        case .login:
            return URL(string: "\(baseUrl)login")
        case .products:
            return URL(string: "\(baseUrl)products")
        case .product(let productId):
            return URL(string: "\(baseUrl)\(productId)")
        }
    }
}
