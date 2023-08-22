import Foundation

public struct ApplicationDetails: Equatable, Sendable {
    public let name: String
    public let contactEmail: String
    public let contactPhone: String
    public let twoFactor: OptionalFeature
    public let lockOnRequest: OptionalFeature
    
    public init(
        name: String,
        contactEmail: String,
        contactPhone: String,
        twoFactor: OptionalFeature = .disabled,
        lockOnRequest: OptionalFeature = .disabled
    ) {
        self.name = name
        self.contactEmail = contactEmail
        self.contactPhone = contactPhone
        self.twoFactor = twoFactor
        self.lockOnRequest = lockOnRequest
    }
}
