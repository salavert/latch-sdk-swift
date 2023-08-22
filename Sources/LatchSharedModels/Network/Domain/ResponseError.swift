import Foundation

public struct ResponseError: Decodable, Equatable, Hashable {
    public let code: Int
    public let message: String
}
