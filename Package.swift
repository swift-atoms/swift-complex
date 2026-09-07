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
        .library(name: "Complex", targets: ["Complex"]),

        .library(name: "Complex Foundation Integration", targets: ["Complex Foundation Integration"]),
        .library(name: "Complex Test Support", targets: ["Complex Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-multiplication.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-addition.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-exponential.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-trigonometry.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-tolerance.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-angle.git",
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
                .product(name: "Multiplication", package: "swift-multiplication"),
                .product(name: "Addition", package: "swift-addition"),
                .product(name: "Exponential", package: "swift-exponential"),
                .product(name: "Trigonometry", package: "swift-trigonometry"),
                .product(name: "Tolerance", package: "swift-tolerance"),
                .product(name: "Angle", package: "swift-angle"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Complex"
        ),
        
        .target(
            name: "Complex Foundation Integration",
            dependencies: [
                .target(name: "Complex"),
            ],
            path: "Sources/Complex Foundation Integration"
        ),
        .target(
            name: "Complex Test Support",
            dependencies: [
                .target(name: "Complex"),
                .product(name: "Tagged Test Support", package: "swift-tagged"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Complex Tests",
            dependencies: [
                .target(name: "Complex"),
                .product(name: "Tagged", package: "swift-tagged"),
                .target(name: "Complex Test Support"),
                .target(name: "Complex Foundation Integration"),
            ],
            path: "Tests/Complex Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
