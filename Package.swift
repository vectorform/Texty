// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Texty",
    products: [
        .library(name: "Texty", targets: ["Texty"]),
    ],
    targets: [
        .target(name: "Texty", path: "Source"),
        .testTarget(name: "TextyTests", dependencies: ["Texty"]),
    ]
)
