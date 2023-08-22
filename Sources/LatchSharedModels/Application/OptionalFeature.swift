import Foundation

public enum OptionalFeature: String, Equatable, Sendable, CaseIterable, Identifiable {
    case mandatory = "MANDATORY"
    case optional = "OPT_IN"
    case disabled = "DISABLED"
    
    public var id: String { rawValue }
}
