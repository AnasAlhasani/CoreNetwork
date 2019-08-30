// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetwork",
    platforms: [.iOS(.v10), .watchOS(.v4)],
    products: [.library(name: "CoreNetwork", targets: ["CoreNetwork"])],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "4.8.2")),
        .package(url: "https://github.com/google/promises.git", .upToNextMajor(from: "1.2.8"))
    ],
    targets: [.target(name: "CoreNetwork", dependencies: ["Alamofire", "PromisesSwift"])],
    swiftLanguageVersions: [.v5]
)
