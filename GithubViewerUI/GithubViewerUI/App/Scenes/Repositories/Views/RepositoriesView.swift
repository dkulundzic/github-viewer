import SwiftUI
import GithubViewerModel
import GithubViewerNetworking
import GithubViewerUserInterface

struct RepositoriesView: View {
  @State private var searchQuery = ""
  @StateObject private var viewModel = RepositoriesViewModel(
    repositoriesNetworkService: DefaultRepositoriesNetworkService()
  )

  var body: some View {
    VStack {
      if viewModel.isLoading {
        ProgressView()
      } else {
        if viewModel.repositories.isEmpty {
          Text(L10n.repositoriesListNoReposAvailableMessage)
            .font(.title3)
        } else {
          ListView(repositories: viewModel.repositories)
            .animation(.default, value: viewModel.selectedSortOption)
        }
      }
    }
    .searchable(text: $searchQuery)
    .onFirstAppearTask {
      await viewModel.loadRepositores()
    }
    .onChange(of: searchQuery) { query in
      viewModel.onSearchQueryUpdated(query)
    }
    .navigationDestination(for: Repository.self) { repository in
      RepositoryDetailsView(repository: repository)
    }
    .navigationTitle(L10n.repositoriesListTitle)
    .toolbar {
      MenuView(
        options: viewModel.sortOptions,
        selectedSortOption: viewModel.selectedSortOption
      ) { option in
        viewModel.onMenuActionTap(option)
      }
    }
  }
}

struct RepositoriesView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView()
  }
}
