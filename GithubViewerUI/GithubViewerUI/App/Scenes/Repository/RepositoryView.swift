import SwiftUI
import ComposableArchitecture
import GithubViewerModel
import GithubViewerDomain

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
          )
        }

        Section {
          Link(destination: viewStore.repository.url) {
            Text(L10n.repositoryWebPageCta)
          }
        }
      }
    }
    .navigationTitle("")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    DevicePreviewView(device: PreviewDevice.Phone.iPhoneSE) {
      RepositoryView(
        store: Store(
          initialState: RepositoryReducer.State(repository: .mock),
          reducer: RepositoryReducer()
        )
      ) { _ in }
    }

    DevicePreviewView {
      RepositoryView(
        store: Store(
          initialState: RepositoryReducer.State(repository: .mock),
          reducer: RepositoryReducer()
        )
      ) { _ in }
    }
  }
}
