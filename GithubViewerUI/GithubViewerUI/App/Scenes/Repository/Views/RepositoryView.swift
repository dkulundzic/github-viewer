import SwiftUI
import ComposableArchitecture
import GithubViewerModel

struct RepositoryView: View {
  let store: StoreOf<RepositoryReducer>
  let onUserTap: ParameterizedAction<User>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        Section {
          VStack(alignment: .leading, spacing: 4) {
            Text(viewStore.repository.name)
              .font(.headline)
            Text(viewStore.description)
              .font(.body)
          }

          LazyVGrid(
            columns: [
              GridItem(alignment: .topLeading),
              GridItem(alignment: .topLeading)
            ],
            alignment: .listRowSeparatorLeading
          ) {
            NamedDataView(
              name: L10n.repositoryLastUpdated,
              data: viewStore.lastUpdated
            )

            NamedDataView(
              name: L10n.repositoryLanguage,
              data: viewStore.language
            )

            NamedDataView(
              name: L10n.repositoryVisibility,
              data: viewStore.visibility
            )
          }
        }

        Section {
          RepositoryStatsView(
            watchers: viewStore.repository.numOfWatchers,
            stars: viewStore.repository.numOfStars,
            issues: viewStore.repository.numOfIssues,
            forks: viewStore.repository.numOfForks
          )
        }

        Section(L10n.repositoryOwnedBy) {
          UserDetailsView(
            imageUrl: viewStore.user.image,
            name: viewStore.user.name
          ) {
            onUserTap(viewStore.user)
          }
        }

        Section {
          Link(destination: viewStore.repository.url) {
            Text(L10n.repositoryWebPageCta)
          }
        }
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
    .navigationTitle("")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      RepositoryView(
        store: Store(
          initialState: RepositoryReducer.State(repository: .mock),
          reducer: RepositoryReducer()
        )
      ) { _ in }
    }
  }
}
