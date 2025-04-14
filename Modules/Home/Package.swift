// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HomeInterface",
            targets: ["HomeInterface"]
        ),
        .library(
            name: "HomeImplementation",
            targets: ["HomeImplementation"]
        ),
    ],
    dependencies: [
        .package(path: "../RouterInterface"),
        .package(path: "../DependencyInjection"),
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
                "DependencyInjection"
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["HomeImplementation", "HomeInterface"]
        ),
    ]
)
