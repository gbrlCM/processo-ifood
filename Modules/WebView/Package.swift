// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebView",
    products: [
        .library(
            name: "WebViewInterface",
            targets: ["WebViewInterface"]
        ),
        .library(
            name: "WebViewImplementation",
            targets: ["WebViewImplementation"]
        ),
    ],
    targets: [
        .target(
            name: "WebViewInterface"
        ),
        .target(
            name: "WebViewImplementation",
            dependencies: ["WebViewInterface"]
        ),
        .testTarget(
            name: "WebViewTests",
            dependencies: ["WebViewImplementation", "WebViewInterface"]
        ),
    ]
)
