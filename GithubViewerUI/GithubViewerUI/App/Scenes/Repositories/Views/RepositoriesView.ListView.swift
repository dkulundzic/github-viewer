import SwiftUI
import GithubViewerModel

extension RepositoriesView {
  struct ListView: View {
    let repositories: [Repository]
    let onRepositoryTap: (Repository) -> Void
    let onUserThumbnailTap: (User) -> Void

    var body: some View {
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(repositories) { repository in
            ItemView(repository: repository) {
              onUserThumbnailTap(repository.user)
            }
            .onTapGesture {
              onRepositoryTap(repository)
            }
          }
        }
      }
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView.ListView(repositories: []) { _ in } onUserThumbnailTap: { _ in }
  }
}
