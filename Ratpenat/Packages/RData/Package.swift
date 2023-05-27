// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RData",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RData",
            targets: ["RData"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "JToolKit", path: "../JToolKit"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RData",
            dependencies: ["JToolKit"],
            resources: [
                .copy("Storage/StorageData.json")
            ]),
        .testTarget(
            name: "RDataTests",
            dependencies: ["RData", "JToolKit"],
            resources: [
                .copy("Fixtures")
            ]
        ),
    ]
)
