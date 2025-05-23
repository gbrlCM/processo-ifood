// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReducerCore",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ReducerCore",
            targets: ["ReducerCore"]
        ),
        .library(
            name: "ReducerTestHelpers",
            targets: ["ReducerTestHelpers"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(path: "../DesignSystem")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ReducerCore",
            dependencies: ["SnapKit", "DesignSystem"]
        ),
        .target(
            name: "ReducerTestHelpers",
            dependencies: ["ReducerCore"]
        ),
        .testTarget(
            name: "ReducerCoreTests",
            dependencies: ["ReducerCore", "ReducerTestHelpers"]
        )
    ]
)
