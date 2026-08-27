// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-complex",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Complex",
            targets: ["Complex"]
        ),
        .library(
            name: "Complex Standard Library Integration",
            targets: ["Complex Standard Library Integration"]
        ),
        .library(
            name: "Complex Apple Foundation Integration",
            targets: ["Complex Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-numeric.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Complex",
            dependencies: [
                .product(name: "Numeric", package: "swift-numeric"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Complex Standard Library Integration",
            dependencies: ["Complex"]
        ),
        .target(
            name: "Complex Apple Foundation Integration",
            dependencies: [
                "Complex",
                "Complex Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Complex Tests",
            dependencies: [
                "Complex",
                "Complex Standard Library Integration",
                .product(name: "Numeric", package: "swift-numeric"),
                .product(
                    name: "Numeric Standard Library Integration",
                    package: "swift-numeric"
                ),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
