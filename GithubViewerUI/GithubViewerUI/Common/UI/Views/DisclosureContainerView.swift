import SwiftUI

struct DisclosureContainerView<Content: View>: View {
  private let content: Content

  init(content: @escaping () -> Content) {
    self.content = content()
  }

  var body: some View {
    HStack {
      content
      Spacer()
      Image(systemName: "chevron.forward")
    }
  }
}

struct DisclosureContainerView_Previews: PreviewProvider {
  static var previews: some View {
    DisclosureContainerView {
      Text("Text")
    }
  }
}
