import Foundation

public struct PairAccountResponse: GenericResponseWithError {
    public let error: ResponseError?
    public let data: ResponseData?
    
    public struct ResponseData: Decodable, Equatable, Hashable {
        public let accountId: String
    }
}
