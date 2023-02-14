import SwiftUI

struct NamedDataView: View {
  let name: String
  let data: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(name)
        .font(.footnote)
      Text(data)
    }
    .padding(.vertical, 1)
  }
}

struct NamedDataView_Previews: PreviewProvider {
  static var previews: some View {
    NamedDataView(name: "Name", data: "John Appleseed")
      .padding()
      .background(RoundedRectangle(cornerRadius: 16).fill(.purple))
      .previewLayout(.sizeThatFits)
  }
}
