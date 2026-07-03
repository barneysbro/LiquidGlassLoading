// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LiquidGlassLoading",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LiquidGlassLoading",
            targets: ["LiquidGlassLoading"]
        )
    ],
    targets: [
        .target(name: "LiquidGlassLoading")
    ]
)
