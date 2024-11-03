//
//  GeneralErrors.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

enum GeneralErrors {
    case urlEncodingFailed

    var message: String {
        switch self {
        case .urlEncodingFailed:
            return "Failed to create url"
        }
    }
}
