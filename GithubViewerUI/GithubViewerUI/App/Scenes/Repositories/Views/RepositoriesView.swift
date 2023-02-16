import SwiftUI
import GithubViewerModel
import GithubViewerNetworking
import ComposableArchitecture

struct RepositoriesView: View {
  private enum Route: Hashable {
    case repository(Repository)
    case user(User)
  }

  @State private var navigationPath: [Route] = []
  @State private var searchQuery = ""

  let store: StoreOf<RepositoriesReducer>

  var body: some View {
    NavigationStack(path: $navigationPath) {
      WithViewStore(store, observe: { $0 }) { viewStore in
        ZStack(alignment: .bottomTrailing) {
          if viewStore.state.isLoading {
            ProgressView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          } else {
            if viewStore.state.repositories.isEmpty {
              Text(L10n.repositoriesListNoReposAvailableMessage)
                .font(.title3)
            } else {
              ListView(repositories: viewStore.state.repositories) { repository in
                navigationPath.append(.repository(repository))
              } onUserThumbnailTap: { user in
                navigationPath.append(.user(user))
              }
              .transition(.opacity)
            }
          }

          MenuView(
            options: viewStore.state.sortOptions,
            selectedSortOption: viewStore.state.selectedSortOption
          ) { option in
            viewStore.send(.onMenuActionTap(option))
          }
          .padding(.trailing, 16)
          .transition(.opacity)
        }
        .animation(.default, value: viewStore.state.selectedSortOption)
        .animation(.default, value: viewStore.state.isLoading)
        .searchable(text: $searchQuery)
        .onFirstAppear {
          Task { viewStore.send(.onFirstAppear) }
        }
        .onChange(of: searchQuery) { query in
          viewStore.send(.onSearchTextChanged(query))
        }
        .navigationDestination(for: Route.self) { route in
          switch route {
          case .repository(let repository):
            RepositoryView(
              store: Store(
                initialState: RepositoryReducer.State(repository: repository),
                reducer: RepositoryReducer()
              )
            )
          case .user(let user):
            UserView(
              store: Store(
                initialState: UserReducer.State(user: user),
                reducer: UserReducer()
              )
            )
          }
        }
        .navigationTitle(L10n.repositoriesListTitle)
      }
    }
  }
}

struct RepositoriesView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView(
      store: Store(
        initialState: RepositoriesReducer.State(),
        reducer: RepositoriesReducer()
      )
    )
  }
}
