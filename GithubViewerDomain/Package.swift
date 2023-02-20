// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "GithubViewerDomain",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "GithubViewerDomain",
      targets: ["GithubViewerDomain"]),
  ],
  dependencies: [
    .package(path: "../GithubViewerModel"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.51.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "GithubViewerDomain",
      dependencies: [
        "GithubViewerModel",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "GithubViewerDomainTests",
      dependencies: ["GithubViewerDomain"]),
  ]
)
