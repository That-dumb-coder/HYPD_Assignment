import Foundation

struct HYPDRequest: NetworkRequest {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let queryParameters: [String : [String]]?
    let body: Data?
    let headers: [String: String]?
    let authorizationToken: String?
}
