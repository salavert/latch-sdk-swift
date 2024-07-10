# Latch SDK for Apple Development

Implementation of Latch SDK in Swift

## 1. Prerequisites

To get the "Application ID" and "Secret", (fundamental values for integrating Latch in any application), it’s necessary to register a developer account in Latch's website: https://latch.tu.com. On the upper right side, click on "Developer area".

## 2. Installation

### 2.1 Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/salavert/latch-sdk-swift.git", .upToNextMajor(from: "0.1.0"))
]
```


## 3. Usage

```swift
import LatchSDK

// Defining application id+secret
return LatchSDK(
    appId: "you-app-id",
    appSecret: "your-app-secret"
)

// Or defining user id+secret and host too
return LatchSDK(
    appId: "you-app-id",
    appSecret: "your-app-secret",
    apiUserId: "your-user-id",
    apiUserSecret: "your-user-secret",
    baseUrl: "https://latch.tu.com"
)
```

Now you can call any of its API endpoints as follows:

```swift
let latchResponse = try await latchSDK.pair(token: token)
```
Within `LatchResponse` you will find `rawData` with response in `Data` type  and both `URLResponse` and `URLRequest` of the network operation for you to manipulate. This response struct offers help in decoding its data:

```swift
import LatchSharedModels

let addOperationResponse = try? latchResponse.decodeAs(AddOperationResponse.self)

print(addOperationResponse.data?.operationId) //  Returned new operation id
print(addOperationResponse.error?.code) // Returned error code
```
