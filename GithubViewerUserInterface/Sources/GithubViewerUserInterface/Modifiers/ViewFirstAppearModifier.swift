import SwiftUI

public struct ViewFirstAppearModifier: ViewModifier {
  public let onAppear: () -> Void
  @State private var didAppearOnce = false

  public func body(content: Content) -> some View {
    content.onAppear {
      if !didAppearOnce {
        didAppearOnce = true
        onAppear()
      }
    }
  }
}

public extension View {
  func onFirstAppear(_ onAppear: @escaping () -> Void) -> some View {
    modifier(
      ViewFirstAppearModifier(onAppear: onAppear)
    )
  }
}
