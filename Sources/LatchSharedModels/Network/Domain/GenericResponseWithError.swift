import Foundation

public protocol GenericResponseWithError: Decodable, Equatable, Hashable {
    var error: ResponseError? { get }
}
