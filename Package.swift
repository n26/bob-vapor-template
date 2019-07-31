// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "BobTheBuilder",
    dependencies: [
        .package(url: "https://github.com/n26/bob", from: "1.0.0"),
    ],
    targets: [
        // The Commands target is the place to add any new custom commands
        // When creating new commands, make sure that their Target Membership is set to `BobCustomCommands` and that they are public
        .target(name: "BobCustomCommands", dependencies: ["Bob"]),
        .target(name: "Run", dependencies: ["BobCustomCommands"])
        
        // If you don't plan to implement any custom commands, you can have only one target
        // .target(name: "Run", dependencies: ["Bob"])
    ]
)

