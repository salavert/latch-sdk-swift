import Foundation

public struct NetworkRequest {
    public let httpMethod: HttpMethod
    public let url: URL
    public let parameters: [String: String]?
    public let headers: [String: String]?
    
    public init(
        httpMethod: HttpMethod,
        url: URL,
        parameters: [String : String]?,
        headers: [String : String]?
    ) {
        self.httpMethod = httpMethod
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }
}
