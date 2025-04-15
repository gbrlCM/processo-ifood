// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PullRequest",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PullRequestImplementation",
            targets: ["PullRequestImplementation"]
        ),
        .library(
            name: "PullRequestInterface",
            targets: ["PullRequestInterface"]
        )
    ],
    targets: [
        .target(
            name: "PullRequestImplementation",
            dependencies: ["PullRequestInterface"]
        ),
        .target(
            name: "PullRequestInterface"
        ),
        .testTarget(
            name: "PullRequestTests",
            dependencies: ["PullRequestImplementation"]
        ),
    ]
)
