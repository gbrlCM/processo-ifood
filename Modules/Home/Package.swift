// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HomeInterface",
            targets: ["HomeInterface"]
        ),
        .library(
            name: "HomeImplementation",
            targets: ["HomeImplementation"]
        )
    ],
    dependencies: [
        .package(path: "../RouterInterface"),
        .package(path: "../DependencyInjection"),
        .package(path: "../Models"),
        .package(path: "../ReducerCore"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "HomeInterface",
            dependencies: ["RouterInterface"]
        ),
        .target(
            name: "HomeImplementation",
            dependencies: [
                "HomeInterface",
                "RouterInterface",
                "DependencyInjection",
                "Models",
                "ReducerCore",
                "DesignSystem",
                "SnapKit"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["HomeImplementation", "HomeInterface"]
        )
    ]
)
