import SwiftUI
import GithubViewerModel

extension RepositoriesView {
  struct ItemView: View {
    let repository: Repository
    let onUserThumbnailTap: () -> Void
    private let imageSize: CGFloat = 75

    var body: some View {
      HStack {
        AsyncImageWithProgress(
          url: repository.thumbnail,
          imageSize: imageSize,
          onTap: onUserThumbnailTap
        )

        VStack(alignment: .leading, spacing: 8) {
          Text(repository.name)
          Text(repository.user.name)
          RepositoryStatsView(
            watchers: repository.numOfWatchers,
            stars: repository.numOfStars,
            issues: repository.numOfIssues,
            forks: repository.numOfForks
          )
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
    DevicePreviewView {
      RepositoriesView.ItemView(repository: .mock) { }
    }

    DevicePreviewView(device: PreviewDevice.Phone.iPhoneSE) {
      RepositoriesView.ItemView(repository: .mock) { }
    }
  }
}
