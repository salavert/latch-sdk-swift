import Foundation

public struct LatchResponse: Equatable, Hashable, Sendable {
    public let request: URLRequest
    public let response: URLResponse
    public let rawData: Data
    
    public init(
        request: URLRequest,
        response: URLResponse,
        rawData: Data
    ) {
        self.request = request
        self.response = response
        self.rawData = rawData
    }
    
    public var httpResponse: HTTPURLResponse? {
        response as? HTTPURLResponse
    }
    
    public func decodeAs<T>(_ type: T.Type) throws -> T where T : Decodable {
        try JSONDecoder().decode(type, from: rawData)
    }
}
