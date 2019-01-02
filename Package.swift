// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "Terse",
    products: [
        .library(name: "Terse", targets: ["Terse"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.8.0"),
    ],
    targets: [
        .target(name: "Terse", dependencies: ["NIO"]),
        .testTarget(name: "TerseTests", dependencies: ["Terse"]),
    ]
)
