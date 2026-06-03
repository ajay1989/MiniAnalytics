// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "MiniAnalytics",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "MiniAnalytics", targets: ["MiniAnalytics"])
    ],
    targets: [
        .target(
            name: "MiniAnalytics"
        ),
        .testTarget(
            name: "MiniAnalyticsTests",
            dependencies: ["MiniAnalytics"]
        )
    ]
)
