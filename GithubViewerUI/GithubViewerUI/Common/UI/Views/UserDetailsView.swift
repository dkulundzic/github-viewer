import SwiftUI

struct UserDetailsView: View {
  let imageUrl: URL
  let name: String
  let onTap: Action

  var body: some View {
    HStack {
      AsyncImageWithProgress(
        url: imageUrl,
        imageSize: 50
      )
      Text(name)
        .padding(.leading, 8)
    }
    .onTapGesture(perform: onTap)
  }
}

// swiftlint:disable force_unwrapping
struct RepositoryDetailsUserView_Previews: PreviewProvider {
  static var previews: some View {
    UserDetailsView(
      imageUrl: URL(string: "https://avatars.githubusercontent.com/u/13629408?v=4")!,
      name: "dkulundzic"
    ) { }
  }
}
