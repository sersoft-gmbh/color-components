// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: Array<SwiftSetting> = [
    .swiftLanguageMode(.v6),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableExperimentalFeature("GlobalConcurrency"),
]

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
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ColorComponents",
            swiftSettings: swiftSettings),
        .target(
            name: "ColorCalculations",
            dependencies: ["ColorComponents"],
            swiftSettings: swiftSettings),
        .target(
            name: "XCHelpers",
            swiftSettings: swiftSettings,
            linkerSettings: [
                .linkedFramework("XCTest", .when(platforms: [.iOS, .macOS, .macCatalyst, .tvOS, .watchOS, .visionOS])),
            ]),
        .testTarget(
            name: "ColorComponentsTests",
            dependencies: [
                "ColorComponents",
                "XCHelpers",
            ],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "ColorCalculationsTests",
            dependencies: [
                "ColorCalculations",
                "XCHelpers",
            ],
            resources: [
                .copy("TestImages"),
            ],
            swiftSettings: swiftSettings),
    ]
)
