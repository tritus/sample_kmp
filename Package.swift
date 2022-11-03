// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MobileCommon",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MobileCommon",
            targets: ["MobileCommon"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .binaryTarget(
            name: "MobileCommon",
            path: "./MobileCommon.xcframework"
        )
    ]
)