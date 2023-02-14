import SwiftUI

struct IconLabel: View {
  let icon: Image
  let iconColor: Color
  let title: String

  init(
    icon: Image,
    iconColor: Color = Color.black,
    title: String
  ) {
    self.icon = icon
    self.iconColor = iconColor
    self.title = title
  }

  var body: some View {
    HStack(spacing: 6) {
      icon
        .foregroundColor(iconColor)
      Text(title)
    }
  }
}

struct IconLabel_Previews: PreviewProvider {
  static var previews: some View {
    IconLabel(icon: Image(systemName: "eye"), title: "Watchers")
  }
}
