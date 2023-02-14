import SwiftUI

struct DefaultLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.icon
      configuration.title
    }
  }
}

extension Label {
  func withDefaultLabelStyle() -> some View {
    self.labelStyle(DefaultLabelStyle())
  }
}
