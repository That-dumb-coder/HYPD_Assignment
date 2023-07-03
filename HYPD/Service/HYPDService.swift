import Foundation

class HYPDService {
    static func performRequest(request: NetworkRequest) async throws -> Data {
        let urlRequest = request.buildRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
        }
        return data
    }
    
    static func decodeResponse<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedResponse = try decoder.decode(T.self, from: data)
        return decodedResponse
    }
}
