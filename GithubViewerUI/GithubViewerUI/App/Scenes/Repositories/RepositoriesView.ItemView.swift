import SwiftUI
import GithubViewerModel

extension RepositoriesView {
  struct ItemView: View {
    let repository: Repository

    var body: some View {
      Text(repository.id.description)
    }
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView.ItemView(repository: .mock)
  }
}
