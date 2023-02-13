// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "GithubViewerNetworking",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "GithubViewerNetworking",
      targets: ["GithubViewerNetworking"]),
  ],
  dependencies: [
    .package(path: "../GithubViewerModel")
  ],
  targets: [
    .target(
      name: "GithubViewerNetworking",
      dependencies: ["GithubViewerModel"]),
    .testTarget(
      name: "GithubViewerNetworkingTests",
      dependencies: ["GithubViewerNetworking"]),
  ]
)
