// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BobTheBuilder",
    products: [
        .library(name: "BobTheBuilder", targets: ["App"]),
    ],
    dependencies: [
        // 👷 Bob
        .package(url: "https://github.com/n26/bob", from: "2.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["Bob"]),
        .target(name: "Run", dependencies: ["App"])
    ]
)

