import Foundation

struct HomeViewResponse: Codable {
    let success: Bool
    let payload: HomeResponse
}

struct HomeResponse: Codable {
    let id, influencerID, duplicateID: String
    let name, slug: String
    let catalogIDS: [String]
    let catalogInfo: [CatalogInfo]
    let status: String
    let order: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case influencerID = "influencer_id"
        case duplicateID = "duplicate_id"
        case name, slug
        case catalogIDS = "catalog_ids"
        case catalogInfo = "catalog_info"
        case status, order
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct CatalogInfo: Codable {
    let id, name, brandID, discountID: String
    let basePrice, retailPrice: Price
    enum CodingKeys: String, CodingKey {
        case id, name
        case brandID = "brand_id"
        case discountID = "discount_id"
        case basePrice = "base_price"
        case retailPrice = "retail_price"
    }
}
