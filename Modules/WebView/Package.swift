// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebView",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "WebViewInterface",
            targets: ["WebViewInterface"]
        ),
        .library(
            name: "WebViewImplementation",
            targets: ["WebViewImplementation"]
        )
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../Network")
    ],
    targets: [
        .target(
            name: "WebViewInterface"
        ),
        .target(
            name: "WebViewImplementation",
            dependencies: ["WebViewInterface", "Network", "DesignSystem"]
        ),
        .testTarget(
            name: "WebViewTests",
            dependencies: ["WebViewImplementation", "WebViewInterface"]
        )
    ]
)
