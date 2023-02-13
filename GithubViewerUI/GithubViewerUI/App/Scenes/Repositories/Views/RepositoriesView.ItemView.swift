import SwiftUI
import GithubViewerModel

extension RepositoriesView {
  struct ItemView: View {
    let repository: Repository
    let onUserThumbnailTap: () -> Void
    private let imageSize: CGFloat = 75

    var body: some View {
      HStack {
        AsyncImage(
          url: repository.thumbnail) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: imageSize, height: imageSize)
              .cornerRadius(16)
              .onTapGesture(perform: onUserThumbnailTap)
          } placeholder: {
            ProgressView()
              .frame(width: imageSize, height: imageSize)
          }

        VStack(alignment: .leading, spacing: 8) {
          Text(repository.name)
          Text(repository.user.name)
          HStack {
            Text(repository.numOfIssues.description)
            Text(repository.numOfWatchers.description)
            Text(repository.numOfForks.description)
          }
          .font(.footnote)
        }
        .padding(.leading, 8)
        .foregroundColor(.black)
        .font(.body)

        Spacer()
      }
      .padding()
    }
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView.ItemView(repository: .mock) { }
  }
}
