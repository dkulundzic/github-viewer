import SwiftUI
import GithubViewerModel
import GithubViewerNetworking
import GithubViewerDomain
import ComposableArchitecture

struct RepositoriesView: View {
  private enum Route: Hashable {
    case repository(Repository)
    case user(User)
  }

  @State private var navigationPath: [Route] = []
  @State private var searchQuery = ""
  @State private var path = NavigationPath()

  let store: StoreOf<RepositoriesReducer>

  var body: some View {
    NavigationStack(path: $path) {
      WithViewStore(store, observe: { $0 }) { viewStore in
        ZStack(alignment: .bottomTrailing) {
          if viewStore.isLoading {
            ProgressView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          } else {
            if viewStore.repositories.isEmpty {
              Text(L10n.repositoriesListNoReposAvailableMessage)
                .font(.title3)
            } else {
              ListView(repositories: viewStore.repositories) { repository in
                path.append(repository)
              } onUserThumbnailTap: { user in
                path.append(user)
              }
                .transition(.opacity)
            }
          }

          MenuView(
            options: viewStore.sortOptions,
            selectedSortOption: viewStore.selectedSortOption
          ) { option in
            viewStore.send(.onMenuActionTap(option))
          }
          .padding(.trailing, 16)
          .transition(.opacity)
        }
        .onFirstAppear {
          Task { viewStore.send(.onFirstAppear) }
        }
        .onChange(of: searchQuery) { query in
          viewStore.send(.onSearchTextChanged(query))
        }
        .animation(.default, value: viewStore.selectedSortOption)
        .animation(.default, value: viewStore.isLoading)
        .searchable(text: $searchQuery)
        .navigationDestination(for: Repository.self) { repository in
          RepositoryView(
            store: Store(
              initialState: RepositoryReducer.State(repository: repository),
              reducer: RepositoryReducer()
            )
          ) { user in
            path.append(user)
          }
        }
        .navigationDestination(for: User.self) { user in
          UserView(
            store: Store(
              initialState: UserReducer.State(user: user),
              reducer: UserReducer()
            )
          )
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
