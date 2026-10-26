// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "LumenDesign",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
    ],
    products: [
        .library(name: "LumenDesign", targets: ["LumenDesign"]),
    ],
    targets: [
        .target(name: "LumenDesign"),
    ]
)
