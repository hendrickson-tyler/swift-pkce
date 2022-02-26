// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-pkce",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
        .macCatalyst("15.0"),
        .tvOS("15.0"),
        .watchOS("8.0")],
    products: [
        .library(
            name: "PKCE",
            targets: ["PKCE"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Realm/SwiftLint", .upToNextMajor(from: "0.0.0"))
    ],
    targets: [
        .target(
            name: "PKCE",
            dependencies: []),
        .testTarget(
            name: "PKCETests",
            dependencies: ["PKCE"]),
    ]
)
