// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let package = Package(
    name: "latch-sdk-swift",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "LatchSDK", targets: ["LatchSDK"]),
        .library(name: "LatchSharedModels", targets: ["LatchSharedModels"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "LatchSharedModels", dependencies: []),
        .target(name: "NetworkClient", dependencies: [
            "LatchSharedModels",
        ]),
        .target(name: "APIClient", dependencies: [
            "NetworkClient",
            "LatchSharedModels",
        ]),
        .target(
            name: "LatchSDK",
            dependencies: [
                "APIClient",
                "LatchSharedModels",
            ]
        ),
        .testTarget(
            name: "LatchSDKTests",
            dependencies: ["LatchSDK"]
        ),
    ]
)
