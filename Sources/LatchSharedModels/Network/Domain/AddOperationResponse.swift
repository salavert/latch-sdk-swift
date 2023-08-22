import Foundation

public struct AddOperationResponse: GenericResponseWithError {
    public var error: ResponseError?
    public let data: ResponseData?
    
    public struct ResponseData: Decodable, Equatable, Hashable {
        public let operationId: String
    }
}
