// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouterInterface",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RouterInterface",
            targets: ["RouterInterface"]
        ),
        .library(
            name: "RouterInterfaceTestHelpers",
            targets: ["RouterInterfaceTestHelpers"]
        )
    ],
    targets: [
        .target(name: "RouterInterface"),
        .target(name: "RouterInterfaceTestHelpers", dependencies: ["RouterInterface"])
    ]
)
