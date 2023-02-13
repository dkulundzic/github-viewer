import SwiftUI
import GithubViewerModel
import GithubViewerNetworking
import GithubViewerUserInterface

struct RepositoriesView: View {
  @StateObject private var viewModel = ViewModel(
    repositoriesNetworkService: DefaultRepositoriesNetworkService()
  )

  var body: some View {
    Group {
      if viewModel.isLoading {
        ProgressView()
      } else {
        ScrollView {
          VStack(alignment: .leading) {
            ForEach(viewModel.repositories) { repository in
              NavigationLink(value: repository) {
                ItemView(repository: repository)
              }
            }
          }
        }
      }
    }
    .onFirstAppear {
      Task { await viewModel.loadRepositores() }
    }
    .navigationDestination(for: Repository.self) { repository in
      RepositoryDetailsView(repository: repository)
    }
    .navigationTitle("Repositories")
  }
}

struct RepositoriesView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView()
  }
}
