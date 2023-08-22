import Foundation

public struct GetSubscriptionResponse: GenericResponseWithError {
    public let error: ResponseError?
    public let data: ResponseData?
    
    public struct ResponseData: Decodable, Equatable, Hashable {
        public let subscription: Subscription
    }
    
    public struct Subscription: Decodable, Equatable, Hashable {
        public let id: String
        public let users: Quota
        public let operations: [String: Quota]
        public let applications: Quota
    }
    
    public struct Quota: Decodable, Equatable, Hashable {
        public let inUse: Int
        public let limit: Int
    }

}
