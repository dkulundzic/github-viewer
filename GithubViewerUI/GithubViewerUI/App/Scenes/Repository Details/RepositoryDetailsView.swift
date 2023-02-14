import SwiftUI
import GithubViewerModel

struct RepositoryDetailsView: View {
  @ObservedObject private var viewModel: RepositoryDetailsViewModel

  init(viewModel: RepositoryDetailsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    Form {
      Section {
        VStack(alignment: .leading, spacing: 4) {
          Text(viewModel.details.name)
            .font(.headline)
          Text(viewModel.details.description)
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
            data: viewModel.details.lastUpdated
          )
#warning("TODO: Localise")
          NamedDataView(
            name: "Language",
            data: viewModel.details.language
          )

#warning("TODO: Localise")
          NamedDataView(
            name: "Visibility",
            data: viewModel.details.visibility
          )
        }
      }

      Section {
        RepositoryDetailsStatsView(
          watchers: viewModel.details.watchers,
          stars: viewModel.details.stars,
          issues: viewModel.details.issues,
          forks: viewModel.details.forks
        )
      }

#warning("TODO: Localise")
      Section("Owned by") {
        RepositoryDetailsUserView(
          url: viewModel.details.userUrl,
          imageUrl: viewModel.details.userImageUrl,
          name: viewModel.details.userName
        )
      }

      Section {
        Link(destination: viewModel.details.url) {
          HStack {
#warning("TODO: Localise")
            Text("See on the web")
            Spacer()
            Image(systemName: "chevron.forward")
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
      RepositoryDetailsView(viewModel: .init(repository: .mock))
    }
  }
}
