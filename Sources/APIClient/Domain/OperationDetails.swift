import Foundation
import LatchSharedModels

public struct OperationDetails: Equatable, Sendable {
    public let name: String
    public let twoFactor: OptionalFeature
    public let lockOnRequest: OptionalFeature
    
    public init(
        name: String,
        twoFactor: OptionalFeature = .disabled,
        lockOnRequest: OptionalFeature = .disabled
    ) {
        self.name = name
        self.twoFactor = twoFactor
        self.lockOnRequest = lockOnRequest
    }
}
