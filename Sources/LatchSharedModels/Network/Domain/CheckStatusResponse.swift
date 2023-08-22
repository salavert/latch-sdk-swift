import Foundation

public struct CheckStatusResponse: GenericResponseWithError {
    public let error: ResponseError?
    public let data: ResponseData?
    
    public struct ResponseData: Decodable, Equatable, Hashable {
        public let operations: [String: Operation]?
    }

    public struct Operation: Decodable, Equatable, Hashable {
        public let status: OperationStatus
    }

    public enum OperationStatus: String, Decodable, Equatable, Hashable {
        case on
        case off
    }
}
