// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouterImplementation",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RouterImplementation",
            targets: ["RouterImplementation"]),
    ],
    dependencies: [
        .package(path: "../RouterInterface"),
        .package(path: "../Home")
    ],
    targets: [
        .target(
            name: "RouterImplementation",
            dependencies: [
                "RouterInterface",
                .product(name: "HomeInterface", package: "Home")
            ]
        ),
        .testTarget(
            name: "RouterImplementationTests",
            dependencies: [
                "RouterImplementation",
            ]
        ),
    ]
)
