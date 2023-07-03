//
//  ProductList.swift
//  HYPD
//
//  Created by Naman Sharma on 01/07/23.
//

import Foundation

struct ProductList: Codable {
    let success: Bool
    let payload: [Product]
}

struct Product: Codable, Identifiable {
    let id: String
    let name: String
    let brandInfo: BrandInfo
    let featuredImage: FeaturedImage
    let basePrice, retailPrice : Price

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case brandInfo = "brand_info"
        case featuredImage = "featured_image"
        case basePrice = "base_price"
        case retailPrice = "retail_price"
    }
}


extension Product {
    var discountPercentage: Double {
        ((basePrice.value - retailPrice.value) / basePrice.value) * 100.0
    }
}

struct BrandInfo: Codable {
    let id, name, username: String
    let logo: FeaturedImage
}

struct FeaturedImage: Codable {
    let src: String
    let height, width: Int
}

// MARK: - Price
struct Price: Codable {
    let value: Double
}
