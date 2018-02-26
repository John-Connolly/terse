// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "terse",
    products: [
        .library(name: "terse", targets: ["terse"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/async.git", from: "3.0.0-rc")
    ],
    targets: [
        .target(name: "terse", dependencies: ["Async"]),
        .testTarget(name: "terseTests", dependencies: ["terse"]),
    ]
)
