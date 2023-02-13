import SwiftUI
import GithubViewerModel

struct RepositoryDetailsView: View {
  let repository: Repository

  var body: some View {
    Text(repository.name)
  }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryDetailsView(repository: .mock)
  }
}
