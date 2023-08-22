# Latch SDK for Apple Development

## 1. Prerequisites

To get the "Application ID" and "Secret", (fundamental values for integrating Latch in any application), it’s necessary to register a developer account in Latch's website: https://latch.telefonica.com. On the upper right side, click on "Developer area".

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
    baseUrl: "https://latch.telefonica.com"
)
```

Now you can call any of its API endpints as follows:

```swift
let (data, responseURL) = try await latchSDK.pair(token: token)
```
