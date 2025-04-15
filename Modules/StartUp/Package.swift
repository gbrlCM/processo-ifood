// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StartUp",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StartUp",
            targets: ["StartUp"]
        )
    ],
    dependencies: [
        .package(path: "../DependencyInjection"),
        .package(path: "../RouterImplementation"),
        .package(path: "../RouterInterface"),
        .package(path: "../Home"),
        .package(path: "../PullRequest"),
        .package(path: "../Network")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name:
                "StartUp",
            dependencies: [
                "DependencyInjection",
                "RouterImplementation",
                "RouterInterface",
                "Network",
                .product(name: "HomeInterface", package: "Home"),
                .product(name: "HomeImplementation", package: "Home"),
                .product(name: "PullRequestInterface", package: "PullRequest"),
                .product(name: "PullRequestImplementation", package: "PullRequest")
            ]
        ),
        .testTarget(
            name: "StartUpTests",
            dependencies: ["StartUp"]
        )
    ]
)
