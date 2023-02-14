import SwiftUI
import GithubViewerNetworking

typealias Action = () -> Void
typealias ParameterizedAction<T> = (T) -> Void

@main
struct GithubViewerUIApp: App {
  var body: some Scene {
    WindowGroup {
      RepositoriesView(viewModel: .init(
        repositoriesNetworkService: DefaultRepositoriesNetworkService())
      )
    }
  }
}
