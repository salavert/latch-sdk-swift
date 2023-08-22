import Foundation

public struct GetApplicationsResponse: GenericResponseWithError {
    public let error: ResponseError?
    public let data: ResponseData?
    
    public struct ResponseData: Decodable, Equatable, Hashable {
        public let operations: [String: Operation]?
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
        
        public init(
            secret: String?,
            contactEmail: String?,
            twoFactor: String,
            imageUrl: String?,
            contactPhone: String?,
            lockOnRequest: String,
            name: String,
            operations: [String : Operation]?
        ) {
            self.secret = secret
            self.contactEmail = contactEmail
            self.twoFactor = twoFactor
            self.imageUrl = imageUrl
            self.contactPhone = contactPhone
            self.lockOnRequest = lockOnRequest
            self.name = name
            self.operations = operations
        }
        
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
