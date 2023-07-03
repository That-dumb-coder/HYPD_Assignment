//
//  HomeViewModel.swift
//  HYPD
//
//  Created by Naman Sharma on 02/07/23.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var products = [String]()
    @Published var homeResponse: HomeResponse?
    @Published var catalogList = [Product]()
    @Published var similarProductList = [Product]()
    
    func addToCatalogList(product: Product) {
        if let index = catalogList.firstIndex(where: { $0.id == product.id }) {
            let removedProduct = catalogList.remove(at: index)
            similarProductList.append(removedProduct)
        }
    }
    
    func performProductRequest() async throws {
        let productRequest = HYPDRequest(baseURL: Constant.baseURL,
                                     path: "/influencer/collection",
                                     method: .get,
                                         queryParameters: ["id": ["6475b6c7cbd697567cc42bda"], "status": ["publish"]], body: nil,
                                     headers: ["Content-Type": "application/json"],
                                     authorizationToken: nil)
        
        let responseData = try await HYPDService.performRequest(request: productRequest)
        let decodedData: HomeViewResponse = try HYPDService.decodeResponse(data: responseData)
        homeResponse = decodedData.payload
        products = homeResponse?.catalogIDS ?? []
        try await fetchCatalogsByID()
        try await performSimilarProductRequest(catalogIds: homeResponse?.catalogIDS ?? [])
    }
    
    func fetchCatalogsByID() async throws {
        let catalogRequest = HYPDRequest(baseURL: Constant.baseURL,
                                     path: "/catalog/basic",
                                     method: .get,
                                     queryParameters: ["id": products], body: nil,
                                     headers: ["Content-Type": "application/json"],
                                     authorizationToken: nil)
        let catalogData = try await HYPDService.performRequest(request: catalogRequest)
        let decodedData: ProductList = try HYPDService.decodeResponse(data: catalogData)
        catalogList = decodedData.payload
    }
    
    func performSimilarProductRequest(catalogIds: [String]) async throws {
        struct SimilarProductRequestModel: Encodable {
            let catalogIds: [String]
        }
        
        let requestModel = SimilarProductRequestModel(catalogIds: catalogIds)
        let encoder = JSONEncoder()
//        not working with the ids in the actual response
//        let bodyData = try encoder.encode(requestModel)
        let bodyData = """
            {
                "catalog_ids": ["63e644b451c9258757e8d9fb", "62bfed7997c0e54293e87a00", "60e818ae11467b0da849ecbc", "61810f38baff1607b2e230b7"]
            }
            """.data(using: .utf8)

        
        
        let request = HYPDRequest(baseURL: Constant.postBaseURL,
                                  path: "/catalog/similar",
                                  method: .post,
                                  queryParameters: nil,
                                  body: bodyData,
                                  headers: ["Content-Type": "application/json", "Authorization": Constant.token],
                                  authorizationToken: nil)
        let responseData = try await HYPDService.performRequest(request: request)
        let decodedResponse: ProductList = try HYPDService.decodeResponse(data: responseData)
        similarProductList = decodedResponse.payload
    }
}

struct SimilarProductRequestModel: Codable {
    let catalogIds: [String]
}


