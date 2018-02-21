// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "terse",
    products: [
        .library(name: "terse", targets: ["terse"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/async.git", .branch("beta"))
    ],
    targets: [
        .target(name: "terse", dependencies: ["Async"]),
        .testTarget(name: "terseTests", dependencies: ["terse"]),
    ]
)
