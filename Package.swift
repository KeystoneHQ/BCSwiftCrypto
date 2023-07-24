// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "BCCrypto",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "BCCrypto",
            targets: ["BCCrypto", "BCWally", "CryptoBase", "SSKR"]),
    ],
    dependencies: [
        .package(url: "https://github.com/WolfMcNally/WolfBase", from: "5.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.7.1"),
        .package(url: "https://github.com/KeystoneHQ/secp256k1.swift.git", from: "0.8.1"),
    ],
    targets: [
        .target(
            name: "BCCrypto",
            dependencies: [
                "CryptoSwift",
                "BCWally",
                "SSKR",
                "CryptoBase",
                .product(name: "secp256k1SwiftLib", package: "secp256k1.swift"),
            ]),
        .binaryTarget(
            name: "BCWally",
            path: "Frameworks/BCWally.xcframework"
        ),
        .binaryTarget(
            name: "CryptoBase",
            path: "Frameworks/CryptoBase.xcframework"
        ),
        .binaryTarget(
            name: "SSKR",
            path: "Frameworks/SSKR.xcframework"
        ),
        .testTarget(
            name: "BCCryptoTests",
            dependencies: [
                "BCCrypto",
                "WolfBase",
                .product(name: "secp256k1SwiftLib", package: "secp256k1.swift"),
            ]),
    ]
)
