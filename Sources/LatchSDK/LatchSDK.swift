import APIClient
import Foundation
import LatchSharedModels

public struct LatchSDK {
    let appId: String
    let appSecret: String
    let apiUserId: String?
    let apiUserSecret: String?
    
    private let apiClient: APIClient
    
    /// Latch SDK
    ///
    /// - Parameters:
    ///   - appId: Application identifier obtained when registering a new application
    ///   - appSecret: Application secret obtained when registering the application
    ///   - apiUserId: API user identifier key, it requires Gold or Premium subscription
    ///   - apiUserSecret: API user secret key, it requires Gold or Premium subscription
    ///   - baseUrl: API base url
    ///   - apiVersion: API version
    public init(
        appId: String,
        appSecret: String,
        apiUserId: String? = nil,
        apiUserSecret: String? = nil,
        baseUrl: URL = URL(string: "https://latch.telefonica.com")!,
        apiVersion: String = "2.0"
    ) {
        self.appId = appId
        self.appSecret = appSecret
        self.apiUserId = apiUserId
        self.apiUserSecret = apiUserSecret
        
        apiClient = .live(
            baseUrl: baseUrl,
            apiVersion: apiVersion,
            appId: appId,
            appSecret: appSecret,
            apiUserId: apiUserId,
            apiUserSecret: apiUserSecret
        )
    }
}

extension LatchSDK {
    /// Pairs a Latch application with a temporal token
    ///
    /// - Parameters:
    ///   - token: The token for pairing the app, generated by the Latch mobile app
    /// - Returns: LatchResponse
    public func pair(token: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.pair(
            token: token,
            web3Wallet: nil,
            web3Signature: nil
        )))
    }
    
    /// Pairs a Latch application
    ///
    /// - Parameters:
    ///   - token: The token for pairing the app, generated by the Latch mobile app
    ///   - web3Wallet: The Ethereum-based account address to pairing the app
    ///   - web3Signature: A proof-of-ownership signature with the account address
    /// - Returns: LatchResponse
    public func pair(
        token: String,
        web3Wallet: String?,
        web3Signature: String?
    ) async throws -> LatchResponse {
        try await apiClient.request(.application(.pair(
            token: token,
            web3Wallet: web3Wallet,
            web3Signature: web3Signature
        )))
    }
    
    /// Pairs a Latch application with an Id
    ///
    /// - Parameter id: The Id for the pairing account, only for non production environment
    /// - Returns: LatchResponse
    public func pairWithId(_ id: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.pairWithId(id)))
    }
    
    /// Despareado de una cuenta de Latch
    ///
    /// - Parameter accountId: The token for pairing the app, generated by the Latch mobile app
    /// - Returns: LatchResponse
    public func unpair(accountId: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.unpair(
            accountId: accountId
        )))
    }
    
    /// Application status for a given accountId
    ///
    /// - Parameter accountId: The accountId which status is going to be retrieved
    /// - Returns: LatchResponse
    public func status(accountId: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.status(
            accountId: accountId,
            operationId: nil,
            silent: nil,
            noOTP: nil
        )))
    }
    
    /// Operation status for a given accountId and operationId while sending some custom data (Like OTP token or a message)
    ///
    /// - Parameter accountId: The accountId which status is going to be retrieved
    /// - Parameter operationId: The operationId which status is going to be retrieved
    /// - Parameter silent: True for not sending lock/unlock push notifications to the mobile devices, false otherwise.
    /// - Parameter noOTP: True for not generating a OTP if needed
    /// - Returns: LatchResponse
    public func operationStatus(
        accountId: String,
        operationId: String,
        silent: Bool,
        noOTP: Bool
    ) async throws -> LatchResponse {
        try await apiClient.request(.application(.status(
            accountId: accountId,
            operationId: !operationId.isEmpty ? operationId : nil,
            silent: silent,
            noOTP: noOTP
        )))
    }

    public func lock(accountId: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.lock(
            accountId: accountId,
            operationId: nil
        )))
    }
    
    public func lock(
        accountId: String,
        operationId: String
    ) async throws -> LatchResponse {
        try await apiClient.request(.application(.lock(
            accountId: accountId,
            operationId: operationId
        )))
    }
    
    public func unlock(accountId: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.unlock(
            accountId: accountId,
            operationId: nil
        )))
    }
    
    public func unlock(
        accountId: String,
        operationId: String
    ) async throws -> LatchResponse {
        try await apiClient.request(.application(.unlock(
            accountId: accountId,
            operationId: operationId
        )))
    }
    
    public func history(
        accountId: String,
        from: TimeInterval? = nil,
        to: TimeInterval? = nil
    ) async throws -> LatchResponse {
        try await apiClient.request(.application(.history(
            accountId: accountId,
            from: from,
            to: to
        )))

    }
    
    public func getUserApplications() async throws -> LatchResponse {
        try await apiClient.request(.user(.application))
    }
    
    public func addUserApplication(details: ApplicationDetails) async throws -> LatchResponse {
        try await apiClient.request(.user(.addApplication(applicationDetails: details)))
    }
    
    public func modifyUserApplication(
        appId: String,
        details: ApplicationDetails
    ) async throws -> LatchResponse {
        try await apiClient.request(.user(.modifyApplication(
            appId: appId,
            applicationDetails: details
        )))
    }
    
    public func deleteUserApplication(appId: String) async throws -> LatchResponse {
        try await apiClient.request(.user(.deleteApplication(appId: appId)))
    }
    
    public func subscription() async throws -> LatchResponse {
        try await apiClient.request(.user(.subscription))
    }
    
    public func addOperation(parentId: String, details: OperationDetails) async throws -> LatchResponse {
        try await apiClient.request(.application(.addOperation(
            parentId: parentId,
            details: .init(
                name: details.name,
                twoFactor: details.twoFactor,
                lockOnRequest: details.lockOnRequest
            )
        )))
    }
    
    public func modifyOperation(operationId: String, details: OperationDetails) async throws -> LatchResponse {
        try await apiClient.request(.application(.modifyOperation(
            operationId: operationId,
            details: .init(
                name: details.name,
                twoFactor: details.twoFactor,
                lockOnRequest: details.lockOnRequest
            )
        )))
    }
    
    public func deleteOperation(operationId: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.deleteOperation(
            operationId: operationId
        )))
    }
    
    public func operation(operationId: String) async throws -> LatchResponse {
        try await apiClient.request(.application(.operation(
            operationId: operationId
        )))
    }
}
