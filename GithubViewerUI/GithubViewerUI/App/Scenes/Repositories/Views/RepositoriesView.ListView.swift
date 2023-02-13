import SwiftUI
import GithubViewerModel

extension RepositoriesView {
  struct ListView: View {
    let repositories: [Repository]

    var body: some View {
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(repositories) { repository in
            NavigationLink(value: repository) {
              ItemView(repository: repository)
            }
          }
        }
      }
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView.ListView(repositories: [
      .mock, .mock, .mock, .mock, .mock, .mock
    ])
  }
}
