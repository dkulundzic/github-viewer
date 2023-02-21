import SwiftUI
import GithubViewerModel
import GithubViewerNetworking
import GithubViewerDomain
import ComposableArchitecture

struct RepositoriesView: View {
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
            if let message = viewStore.infoMessage {
              Text(message)
                .font(.title3)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
              ListView(repositories: viewStore.repositories) { repository in
                performNavigation(value: repository)
              } onUserThumbnailTap: { user in
                performNavigation(value: user)
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
            performNavigation(value: user)
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

  private func performNavigation(value: any Hashable) {
    switch value {
    case is User:
      if Environment.isProduction { path.append(value) }
    case is Repository:
      if Environment.current != .develop { path.append(value) }
    default:
      return
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
