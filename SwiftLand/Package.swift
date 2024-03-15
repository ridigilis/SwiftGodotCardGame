import PackageDescription

let package = Package(
    name: "SwiftGodotCardGame",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "SwiftGodotCardGame",
            type: .dynamic,
            targets: ["SwiftGodotCardGame"]),
    ],
    dependencies: [
        .package(url: "https://github.com/migueldeicaza/SwiftGodot", branch: "main")
    ],
    targets: [
        .target(
            name: "SwiftGodotCardGame",
            dependencies: [
                "SwiftGodot",
            ],
            swiftSettings: [.unsafeFlags(["-suppress-warnings"])]
        ),
        .testTarget(
            name: "SwiftGodotCardGameTests",
            dependencies: ["SwiftGodotCardGame"]),
    ]
)
