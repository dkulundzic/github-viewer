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
#warning("TODO: Localise")
            NamedDataView(
              name: "Last updated",
              data: viewStore.state.lastUpdated
            )
#warning("TODO: Localise")
            NamedDataView(
              name: "Language",
              data: viewStore.state.language
            )

#warning("TODO: Localise")
            NamedDataView(
              name: "Visibility",
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

#warning("TODO: Localise")
        Section("Owned by") {
          RepositoryUserView(
            url: viewStore.state.userUrl,
            imageUrl: viewStore.state.userImageUrl,
            name: viewStore.state.userName
          )
        }

        Section {
          Link(destination: viewStore.state.url) {
            HStack {
#warning("TODO: Localise")
              Text("See on the web")
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
