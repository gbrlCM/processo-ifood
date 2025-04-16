// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PullRequest",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PullRequestImplementation",
            targets: ["PullRequestImplementation"]
        ),
        .library(
            name: "PullRequestInterface",
            targets: ["PullRequestInterface"]
        )
    ],
    dependencies: [
        .package(path: "../ReducerCore"),
        .package(path: "../Network"),
        .package(path: "../Models"),
        .package(path: "../DesignSystem"),
        .package(path: "../DependencyInjection"),
        .package(path: "../RouterInterface"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "PullRequestImplementation",
            dependencies: [
                "PullRequestInterface",
                "ReducerCore",
                "Network",
                "Models",
                "DesignSystem",
                "DependencyInjection",
                "RouterInterface",
                "SnapKit"
            ]
        ),
        .target(
            name: "PullRequestInterface"
        ),
        .testTarget(
            name: "PullRequestTests",
            dependencies: ["PullRequestImplementation"]
        )
    ]
)
