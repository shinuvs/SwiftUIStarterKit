//
//  ApiEndPoint.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    var baseUrl: String {
        switch self {
        case .development:
            return "https://fakestoreapi.com/"
        case .staging:
            return "https://fakestoreapi.com/"
        case .production:
            return "https://fakestoreapi.com/"
        }
    }
}
