import SwiftUI
import GithubViewerModel
import GithubViewerNetworking

struct RepositoriesView: View {
  @StateObject private var viewModel = ViewModel(
    repositoriesNetworkService: DefaultRepositoriesNetworkService()
  )

  var body: some View {
    ScrollView {
      ForEach(viewModel.repositories) { repository in
        ItemView(repository: repository)
      }
    }
    .task {
      await viewModel.loadRepositores()
    }
  }
}

struct RepositoriesView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView()
  }
}
