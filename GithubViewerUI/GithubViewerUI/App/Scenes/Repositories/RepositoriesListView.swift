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
            Button {
              onRepositoryTap(repository)
            } label: {
              ItemView(repository: repository) {
                onUserThumbnailTap(repository.user)
              }
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
