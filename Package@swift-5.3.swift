// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "color-components",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ColorComponents",
            targets: ["ColorComponents"]),
        .library(
            name: "ColorCalculations",
            targets: ["ColorCalculations"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "ColorComponents"),
        .target(
            name: "ColorCalculations",
            dependencies: ["ColorComponents"]),
        .target(
            name: "XCHelpers",
            linkerSettings: [
                .linkedFramework("XCTest", .when(platforms: [.iOS, .macOS, .macCatalyst, .tvOS, .watchOS])),
            ]),
        .testTarget(
            name: "ColorComponentsTests",
            dependencies: [
                "ColorComponents",
                "XCHelpers",
            ]),
        .testTarget(
            name: "ColorCalculationsTests",
            dependencies: [
                "ColorCalculations",
                "XCHelpers",
            ],
            resources: [
                .copy("TestImages"),
            ]),
    ]
)
