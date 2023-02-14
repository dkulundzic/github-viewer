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
        Text(viewModel.details.repositoryDescription)
          .multilineTextAlignment(.leading)
          .lineLimit(6)

        LazyVGrid(
          columns: [GridItem(), GridItem()],
          alignment: .leading
        ) {
#warning("TODO: Localise")
          NamedDataView(
            name: "Name",
            data: viewModel.details.repositoryName
          )
#warning("TODO: Localise")
          NamedDataView(
            name: "Last updated",
            data: viewModel.details.repositoryLastUpdated
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
        Link(destination: viewModel.details.repositoryUrl) {
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
