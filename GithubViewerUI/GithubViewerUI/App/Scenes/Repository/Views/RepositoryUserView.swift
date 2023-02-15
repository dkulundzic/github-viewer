import SwiftUI

struct RepositoryUserView: View {
  let url: URL
  let imageUrl: URL
  let name: String

  var body: some View {
    Link(destination: url) {
      DisclosureContainerView {
        HStack {
          AsyncImageWithProgress(
            url: imageUrl,
            imageSize: 50
          )
          Text(name)
            .padding(.leading, 8)
        }
      }
    }
  }
}

// swiftlint:disable force_unwrapping
struct RepositoryDetailsUserView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryUserView(
      url: URL(string: "https://github.com/dkulundzic")!,
      imageUrl: URL(string: "https://avatars.githubusercontent.com/u/13629408?v=4")!,
      name: "dkulundzic"
    )
  }
}
