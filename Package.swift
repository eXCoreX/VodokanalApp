// swift-tools-version:5.7
import PackageDescription
let package = Package(
    name: "VodokanalApp",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .executable(name: "VodokanalApp", targets: ["VodokanalApp"])
    ],
    dependencies: [
        .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0")
    ],
    targets: [
        .executableTarget(
            name: "VodokanalApp",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak")
            ],
            resources: [
                .copy("vodokanal-background.jpeg"),
                .copy("cute-cat.jpeg")
            ]),
        .testTarget(
            name: "VodokanalAppTests",
            dependencies: ["VodokanalApp"]),
    ]
)
