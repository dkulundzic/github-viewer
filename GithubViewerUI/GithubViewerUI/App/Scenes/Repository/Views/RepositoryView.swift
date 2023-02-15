import SwiftUI
import ComposableArchitecture
import GithubViewerModel

struct RepositoryView: View {
  let store: StoreOf<RepositoryReducer>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        Section {
          VStack(alignment: .leading, spacing: 4) {
            Text(viewStore.state.name)
              .font(.headline)
            Text(viewStore.state.description)
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
              data: viewStore.state.lastUpdated
            )

            NamedDataView(
              name: L10n.repositoryLanguage,
              data: viewStore.state.language
            )

            NamedDataView(
              name: L10n.repositoryVisibility,
              data: viewStore.state.visibility
            )
          }
        }

        Section {
          RepositoryStatsView(
            watchers: viewStore.state.watchers,
            stars: viewStore.state.stars,
            issues: viewStore.state.issues,
            forks: viewStore.state.forks
          )
        }

        Section(L10n.repositoryOwnedBy) {
          RepositoryUserView(
            url: viewStore.state.userUrl,
            imageUrl: viewStore.state.userImageUrl,
            name: viewStore.state.userName
          )
        }

        Section {
          Link(destination: viewStore.state.url) {
            HStack {
              Text(L10n.repositoryWebPageCta)
              Spacer()
              Image(systemName: "chevron.forward")
            }
          }
        }
      }
    }
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
      )
    }
  }
}
