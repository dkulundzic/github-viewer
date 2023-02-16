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
            Text(viewStore.name)
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
            watchers: viewStore.watchers,
            stars: viewStore.stars,
            issues: viewStore.issues,
            forks: viewStore.forks
          )
        }

        Section(L10n.repositoryOwnedBy) {
          UserDetailsView(
            url: viewStore.userUrl,
            imageUrl: viewStore.userImageUrl,
            name: viewStore.userName
          )
        }

        Section {
          DisclosureContainerView {
            Link(destination: viewStore.url) {
              Text(L10n.repositoryWebPageCta)
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
