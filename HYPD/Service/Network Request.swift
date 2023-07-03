import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkRequest {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: [String]]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var authorizationToken: String? { get }
}

extension NetworkRequest {
    var url: URL {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        queryParameters?.forEach { key, values in
            let queryItems = values.map { URLQueryItem(name: key, value: $0) }
            if let existingItems = urlComponents?.queryItems {
                urlComponents?.queryItems = existingItems + queryItems
            } else {
                urlComponents?.queryItems = queryItems
            }
        }
        return urlComponents?.url ?? baseURL
    }
    
    func buildRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
