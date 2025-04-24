// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "MoonPhaseView",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "MoonPhaseView",
            targets: ["MoonPhaseView"]),
    ],
    targets: [
        .target(
            name: "MoonPhaseView"),
        .testTarget(
            name: "MoonPhaseViewTests",
            dependencies: ["MoonPhaseView"]
        ),
    ]
)
