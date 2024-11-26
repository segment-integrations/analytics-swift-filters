// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsFilters",
    platforms: [
        .macOS("10.15"),
        .iOS("13.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AnalyticsFilters",
            targets: ["AnalyticsFilters"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/segment-integrations/analytics-swift-live.git", from: "3.1.1"),
        .package(url: "https://github.com/segmentio/analytics-swift.git", from: "1.6.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AnalyticsFilters",
            dependencies: [
                .product(name: "Segment", package: "analytics-swift"),
                .product(name: "AnalyticsLive", package: "analytics-swift-live"),
            ]),
        .testTarget(
            name: "AnalyticsFilters-Tests",
            dependencies: ["AnalyticsFilters"]),
    ]
)
