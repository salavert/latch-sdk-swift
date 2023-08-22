import Foundation
import LatchSharedModels

/// NetworkClient
///
/// This client helps to compose an URLRequest in order to perform a URLSession.data request
public struct NetworkClient {

    public var dataWithQueryItems: (
        _ url: URL,
        _ queryItems: [String: String]?,
        _ headers: [String: String]?
    ) async throws -> LatchResponse
    
    public var dataWithParameters: (
        _ method: HttpMethod,
        _ url: URL,
        _ parameters: [String: String]?,
        _ headers: [String: String]?
    ) async throws -> LatchResponse
}

extension NetworkClient {
    public static func live(
        session: URLSession = .shared
    ) -> Self {
        func getURLRequest(_ url: URL, queryItems: [String: String]? = nil) -> URLRequest? {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
            urlComponents.queryItems = queryItems?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            guard let url = urlComponents.url else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }
        
        func getURLRequest(_ url: URL, method: HttpMethod, parameters: [String: String]? = nil) throws -> URLRequest? {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if let parameters {
                request.httpBody = parameters.serializedURLQuery().data(using: .utf8)
            }
            return request
        }
        
        return Self(
            dataWithQueryItems: { url, queryItems, headers in
                guard var request =  getURLRequest(url, queryItems: queryItems) else {
                    throw NetworkError.invalidRequest
                }
                headers?.forEach {
                    request.addValue($0.value, forHTTPHeaderField: $0.key)
                }
                let (data, response) = try await session.data(for: request)
                return .init(request: request, response: response, rawData: data)
            },
            dataWithParameters: { method, url, parameters, headers in
                guard var request = try getURLRequest(url, method: method, parameters: parameters) else {
                    throw NetworkError.invalidRequest
                }
                headers?.forEach {
                    request.addValue($0.value, forHTTPHeaderField: $0.key)
                }
                let (data, response) = try await session.data(for: request)
                return .init(request: request, response: response, rawData: data)
            }
        )
    }
}
