import SwiftUI

struct DevicePreviewView<Content: View>: View {
  typealias DeviceIdentifier = String
  let device: DeviceIdentifier
  let content: Content

  init(
    device: DeviceIdentifier = PreviewDevice.Phone.iPhone14Pro,
    @ViewBuilder content: () -> Content
  ) {
    self.device = device
    self.content = content()
  }
  var body: some View {
    content
      .previewDisplayName(device)
      .previewDevice(.init(rawValue: device))
  }
}

struct DevicePreviewView_Previews: PreviewProvider {
  static var previews: some View {
    DevicePreviewView {
      Text("I'm some text, pleased to meet you.")
    }
  }
}

