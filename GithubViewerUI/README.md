# Github Viewer

## Project structure

A Xcode workspace with Swift packages (added locally) and the SwiftUI app. To open the project, be sure to open the `.xcworkspace` file,
as the workspace contains build settings that binds everything together.

## Architecture

The app uses the [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) to architect the codebase. TCA is a 
REDUX-like architecture, that's very clean, easily testable and provides understandable and logical separation of concern.

One of the wondreous things of TCA, we could easily plug the same domain logic into UIKit, AppKit or any other view technology, connecting
everything with Combine. This would be a bonus feature, but it's out of scope of this assignment.

## Features and bonus points

The app has all of the required features and a couple of bonus points - multiple environments and unit tests.    
