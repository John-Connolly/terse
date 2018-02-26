// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "Terse",
    products: [
        .library(name: "Terse", targets: ["Terse"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/async.git", from: "1.0.0-rc")
    ],
    targets: [
        .target(name: "Terse", dependencies: ["Async"]),
        .testTarget(name: "TerseTests", dependencies: ["Terse"]),
    ]
)
