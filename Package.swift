// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PentabarfKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "PentabarfKit",
            targets: ["PentabarfKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/yahoojapan/SwiftyXMLParser", from: Version(5, 6, 0))
    ],
    targets: [
        .target(
            name: "PentabarfKit",
            dependencies: [
                "SwiftyXMLParser"
            ]
        ),
        .testTarget(
            name: "PentabarfKitTests",
            dependencies: ["PentabarfKit"],
            resources: [
                .process("TestResources"),
            ]
        )
    ]
)
