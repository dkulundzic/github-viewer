import SwiftUI
import GithubViewerModel
import GithubViewerNetworking
import GithubViewerUserInterface

struct RepositoriesView: View {
  private enum Route: Hashable {
    case repository(Repository)
    case user(User)
  }

  @State private var navigationPath: [Route] = []
  @State private var searchQuery = ""
  @ObservedObject private var viewModel: RepositoriesViewModel

  init(viewModel: RepositoriesViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationStack(path: $navigationPath) {
      ZStack(alignment: .bottomTrailing) {
        if viewModel.isLoading {
          ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
          if viewModel.repositories.isEmpty {
            Text(L10n.repositoriesListNoReposAvailableMessage)
              .font(.title3)
          } else {
            ListView(repositories: viewModel.repositories) { repository in
              navigationPath.append(.repository(repository))
            } onUserThumbnailTap: { user in
              navigationPath.append(.user(user))
            }
            .transition(.opacity)
          }
        }

        MenuView(
          options: viewModel.sortOptions,
          selectedSortOption: viewModel.selectedSortOption
        ) { option in
          viewModel.onMenuActionTap(option)
        }
        .padding(.trailing, 16)
        .transition(.opacity)
      }
      .animation(.default, value: viewModel.selectedSortOption)
      .animation(.default, value: viewModel.isLoading)
      .searchable(text: $searchQuery)
      .onFirstAppearTask {
        await viewModel.loadRepositores()
      }
      .onChange(of: searchQuery) { query in
        viewModel.onSearchQueryUpdated(query)
      }
      .navigationDestination(for: Route.self) { route in
        switch route {
        case .repository(let repository):
          RepositoryDetailsView(viewModel: .init(repository: repository))
        case .user(let user):
          UserDetailsView(user: user)
        }
      }
      .navigationTitle(L10n.repositoriesListTitle)
    }
  }
}

struct RepositoriesView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView(
      viewModel: .init(
        repositoriesNetworkService: DefaultRepositoriesNetworkService()
      )
    )
  }
}
