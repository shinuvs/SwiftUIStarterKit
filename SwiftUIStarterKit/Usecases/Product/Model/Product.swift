//
//  Product.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

struct Product : Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Decodable, Equatable {
        let rate: Double
        let count: Int
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.description == rhs.description &&
        lhs.category == rhs.category &&
        lhs.image == rhs.image &&
        lhs.rating == rhs.rating
    }
}
