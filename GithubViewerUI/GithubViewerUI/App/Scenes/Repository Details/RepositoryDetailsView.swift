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
        RepositoryDetailsStatsView(
          watchers: viewModel.details.watchers,
          stars: viewModel.details.stars,
          issues: viewModel.details.issues
        )
      }

      Section {
        NamedDataView(
          name: viewModel.details.name,
          data: viewModel.details.description
        )

        LazyVGrid(
          columns: [GridItem(), GridItem()],
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
        }
      }

#warning("TODO: Localise")
      Section("Owned by") {
        Link(destination: viewModel.details.userUrl) {
          DisclosureContainerView {
            HStack {
              AsyncImageWithProgress(
                url: viewModel.details.userImageUrl,
                imageSize: 50
              )
              Text(viewModel.details.userName)
                .padding(.leading, 8)
            }
          }
        }
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
