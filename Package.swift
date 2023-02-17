// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VideoView",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "VideoView", targets: ["VideoView"]),
    ],
    targets: [
        .target(
            name: "VideoView",
            dependencies: [],
            path: "Sources") ],
    swiftLanguageVersions: [.v5]
)

