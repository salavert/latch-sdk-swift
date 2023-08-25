import CommonCrypto
import CryptoKit
import Foundation
import LatchSharedModels
import NetworkClient

public struct APIClient {
    public var request: @Sendable (_ endpoint: Endpoint) async throws -> LatchResponse
}

extension APIClient {
    public static func live(
        baseUrl: URL,
        apiVersion: String,
        appId: String,
        appSecret: String,
        apiUserId: String? = nil,
        apiUserSecret: String? = nil
    ) -> Self {
        let apiBaseUrl = baseUrl.appendingPathComponent("api/\(apiVersion)")
        let networkClient: NetworkClient = .live()
        
        return Self(
            request: { endpoint in
                let httpMethod = endpoint.httpMethod
                let url = apiBaseUrl.appendingPathComponent(endpoint.path)
                let parameters = endpoint.parameters
                
                var secret = appSecret
                var requestId = appId
                if endpoint.requestId == .userId, let apiUserId, let apiUserSecret {
                    secret = apiUserSecret
                    requestId = apiUserId
                }
                
                let headers = try authenticationHeaders(
                    httpMethod: httpMethod,
                    queryString: url.relativePath,
                    xHeaders: nil,
                    params: parameters,
                    utc: Date.currentUTC,
                    secret: secret,
                    requestId: requestId
                )
                
                let request = NetworkRequest(
                    httpMethod: httpMethod,
                    url: url,
                    parameters: parameters,
                    headers: headers
                )
                
                switch request.httpMethod {
                case .get:
                    return try await networkClient.dataWithQueryItems(request.url, request.parameters, request.headers)
                case .post:
                    return try await networkClient.dataWithParameters(.post, request.url, request.parameters, request.headers)
                case .put:
                    return try await networkClient.dataWithParameters(.put, request.url, request.parameters, request.headers)
                case .delete:
                    return try await networkClient.dataWithParameters(.delete, request.url, request.parameters, request.headers)
                case .update:
                    return try await networkClient.dataWithParameters(.update, request.url, request.parameters, request.headers)
                }
            }
        )
    }
}

fileprivate func authenticationHeaders(
    httpMethod: HttpMethod,
    queryString: String,
    xHeaders: [String: String]?,
    params: [String: String]?,
    utc: String,
    secret: String,
    requestId: String
) throws -> [String: String] {
    var stringToSign = ""
    stringToSign += httpMethod.rawValue
    stringToSign += "\n"
    stringToSign += utc
    stringToSign += "\n"
    stringToSign += getSerializedHeaders(xHeaders)
    stringToSign += "\n"
    stringToSign += queryString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if let params = params, !params.isEmpty {
        stringToSign += "\n"
        stringToSign += params.serializedURLQuery()
    }
    
    let signedData = try signData(stringToSign, withSecret: secret)
    let authorizationHeader = "11PATHS \(requestId) \(signedData)"
    
    var headers = [String: String]()
    headers["Authorization"] = authorizationHeader
    headers["X-11paths-Date"] = utc
    if httpMethod == .post || httpMethod == .put {
        headers["Content-Type"] = "application/x-www-form-urlencoded"
    }
    return headers
}

fileprivate func getSerializedParams(_ params: [String: String]) -> String {
    params.sorted { $0.key < $1.key }
        .map { "\($0.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)" }
        .joined(separator: "&")
}

fileprivate func signData(_ data: String, withSecret secret: String) throws -> String {
    let dataToSign = data.data(using: .utf8) ?? Data()
    let secretData = secret.data(using: .utf8) ?? Data()
    var result = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
    dataToSign.withUnsafeBytes { dataPtr in
        secretData.withUnsafeBytes { secretPtr in
            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), secretPtr.baseAddress, secretData.count, dataPtr.baseAddress, dataToSign.count, &result)
        }
    }
    let signatureData = Data(result)
    return signatureData.base64EncodedString()
}

fileprivate func getSerializedHeaders(_ xHeaders: [String: String]?) -> String {
    guard let xHeaders = xHeaders else {
        return ""
    }
    var serializedHeaders = ""
    let sortedHeaders = xHeaders.keys.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
    for key in sortedHeaders {
        if key.lowercased().hasPrefix("X-11paths".lowercased()) {
            let value = xHeaders[key]!
            serializedHeaders += "\(key):\(value) "
        }
    }
    return serializedHeaders.trimmingCharacters(in: .whitespaces)
}
