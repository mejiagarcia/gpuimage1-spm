// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "GPUImage",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "GPUImage",
            targets: ["GPUImage"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GPUImage",
            dependencies: [],
            path: "Source",
            resources: [.copy("Resources")],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
            ]
        )
    ]
)