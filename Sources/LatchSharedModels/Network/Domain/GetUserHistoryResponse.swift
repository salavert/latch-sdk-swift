import Foundation

public struct GetUserHistoryResponse: GenericResponseWithError {
    public let error: ResponseError?
    public let data: ResponseData?
    
    public struct ResponseData: Decodable, Equatable, Hashable {
        public let history: [History]
        public let clientVersion: [ClientVersion]
        public let count: Int
        public let lastSeen : Int
    }
    
    public struct History: Decodable, Equatable, Hashable {
        public let action: String
        public let t: Int
        public let what: String
        public let was: String?
        public let value: String
        public let userAgent: String
        public let name: String
        public let ip: String
    }
    
    public struct ClientVersion: Decodable, Equatable, Hashable {
        public let platform: String
        public let app: String
    }
    
    public struct Operation: Decodable, Equatable, Hashable {
        public let secret: String?
        public let contactEmail: String?
        public let twoFactor: String
        public let imageUrl: String?
        public let contactPhone: String?
        public let lockOnRequest: String
        public let name: String
        public let operations: [String: Operation]?
        
        public enum CodingKeys: String, CodingKey {
            case secret
            case contactEmail
            case twoFactor = "two_factor"
            case imageUrl
            case contactPhone
            case lockOnRequest = "lock_on_request"
            case name
            case operations
        }
    }
}
