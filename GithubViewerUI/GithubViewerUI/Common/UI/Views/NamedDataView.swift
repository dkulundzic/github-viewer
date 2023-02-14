import SwiftUI

struct NamedDataView: View {
  let name: String
  let data: String

  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      Text(name)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundColor(.gray)
      Text(data)
        .multilineTextAlignment(.leading)
    }
    .padding(.vertical, 1)
  }
}

struct NamedDataView_Previews: PreviewProvider {
  static var previews: some View {
    NamedDataView(name: "Name", data: "John Appleseed")
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
