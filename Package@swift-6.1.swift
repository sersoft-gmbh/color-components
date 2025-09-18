// swift-tools-version:6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: Array<SwiftSetting> = [
    .swiftLanguageMode(.v6),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
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
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
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
        .testTarget(
            name: "ColorComponentsTests",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
                "ColorComponents",
            ],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "ColorCalculationsTests",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
                "ColorCalculations",
            ],
            resources: [
                .copy("TestImages"),
            ],
            swiftSettings: swiftSettings),
    ]
)

import class Foundation.ProcessInfo

// We need this to not have to limit our package to macOS 13+. Remove once this is anyways the lowest deployment target.
if ProcessInfo.processInfo.environment["ENABLE_BENCHMARKS"] == "1" {
    package.dependencies.append(.package(url: "https://github.com/ordo-one/package-benchmark", from: "1.29.0"))
    package.platforms = package.platforms ?? []
    package.platforms?.append(.macOS(.v13))
    package.targets.append(.executableTarget(
        name: "ColorCalculationsBenchmarks",
        dependencies: [
            .product(name: "Benchmark", package: "package-benchmark"),
            "ColorCalculations",
        ],
        path: "Benchmarks/ColorCalculationsBenchmarks",
        resources: [
            .copy("TestImages"),
        ],
        swiftSettings: swiftSettings,
        plugins: [
            .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
        ]))
}
