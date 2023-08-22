import Foundation
import LatchSharedModels
import NetworkClient

public enum Endpoint: Equatable {
    case application(ApplicationRoute)
    case user(UserRoute)
    
    public enum ApplicationRoute: Equatable, Sendable {
        case addOperation(parentId: String, details: OperationDetails)
        case deleteOperation(operationId: String)
        case history(accountId: String, from: TimeInterval?, to: TimeInterval?)
        case instance
        case lock(accountId: String, operationId: String?)
        case modifyOperation(operationId: String, details: OperationDetails)
        case operation(operationId: String)
        case pair(token: String, web3Wallet: String?, web3Signature: String?)
        case status(accountId: String, operationId: String?, silent: Bool?, noOTP: Bool?)
        case unlock(accountId: String, operationId: String?)
        case unpair(accountId: String)
    }
        
    public enum UserRoute: Equatable, Sendable {
        case addApplication(applicationDetails: ApplicationDetails)
        case deleteApplication(appId: String)
        case modifyApplication(appId: String, applicationDetails: ApplicationDetails)
        case application
        case subscription
    }
}

extension Endpoint {    
    var requestId: RequestIdType {
        switch self {
        case .application:
            return .applicationId
        case .user:
            return .userId
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case let .application(route):
            switch route {
            case let .pair(_, web3Wallet, web3Signature):
                if web3Wallet != nil, web3Signature != nil {
                    return .post
                } else {
                    return .get
                }
            case .lock,
                    .unlock:
                return .post
            case .unpair,
                    .status,
                    .history:
                return .get
            case .operation:
                return .get
            case .addOperation:
                return .put
            case .modifyOperation:
                return .post
            case .deleteOperation:
                return .delete
            case .instance:
                fatalError("Http Method not defined")
            }
        case let .user(route):
            switch route {
            case .addApplication:
                return .put
            case .application:
                return .get
            case .deleteApplication:
                return .delete
            case .modifyApplication:
                return .post
            case .subscription:
                return .get
            }
        }
    }
    
    public var path: String {
        switch self {
        case let .application(route):
            switch route {
            case let .pair(token, _, _):
                return "pair/\(token)"
                
            case let .unpair(accountId):
                return "unpair/\(accountId)"
                
            case let .status(accountId, operationId, silent, noOTP):
                var path = "status/\(accountId)"
                if let operationId {
                    path += "/op/\(operationId)"
                }
                if let noOTP, noOTP {
                    path += "/nootp"
                }
                if let silent, silent {
                    path += "/silent"
                }
                return path
                
            case let .lock(accountId, operationId):
                var path = "lock/\(accountId)"
                if let operationId, !operationId.isEmpty {
                    path += "/op/\(operationId)"
                }
                return path
                
            case let .unlock(accountId, operationId):
                var path = "unlock/\(accountId)"
                if let operationId, !operationId.isEmpty {
                    path += "/op/\(operationId)"
                }
                return path
                
            case let .history(accountId, from, to):
                if let from, let to {
                    return "history/\(accountId)/\(Int(from))/\(Int(to))"
                } else {
                    return "history/\(accountId)"
                }
                
            case .addOperation:
                return "operation"
                
            case let .operation(operationId),
                let .modifyOperation(operationId,_),
                let .deleteOperation(operationId):
                return "operation/\(operationId)"
                
            default:
                return "\(route)-not-implemented"
            }
        case let .user(route):
            switch route {
            case .addApplication,
                    .application:
                return "application"
            case let .deleteApplication(appId),
                let .modifyApplication(appId,_):
                return "application/\(appId)"
            case .subscription:
                return "subscription"
            }
        }
    }
    
    public var parameters: [String: String]? {
        switch self {
        case let .application(route):
            switch route {
            case let .pair(_, web3Wallet, web3Signature):
                if let web3Wallet, let web3Signature {
                    return [
                        "wallet": web3Wallet,
                        "signature": web3Signature,
                    ]
                } else {
                    return nil
                }
            case let .addOperation(parentId, details):
                return [
                    "parentId": parentId,
                    "name": details.name,
                    "two_factor": details.twoFactor.rawValue,
                    "lock_on_request": details.lockOnRequest.rawValue
                ]
            case let .modifyOperation(_,details):
                return [
                    "name": details.name,
                    "two_factor": details.twoFactor.rawValue,
                    "lock_on_request": details.lockOnRequest.rawValue
                ]
            case .unpair,
                    .lock,
                    .unlock,
                    .history,
                    .status,
                    .deleteOperation,
                    .operation:
                return nil
            case .instance:
                fatalError("Parameters not defined")
            }
        case let .user(route):
            switch route {
            case .application,
                    .deleteApplication:
                return nil
            case let .addApplication(details),
                let .modifyApplication(_, details):
                return [
                    "name": details.name,
                    "contactEmail": details.contactEmail,
                    "contactPhone": details.contactPhone,
                    "two_factor": details.twoFactor.rawValue,
                    "lock_on_request": details.lockOnRequest.rawValue
                ]
            case .subscription:
                return nil
            }
        }
    }
}
