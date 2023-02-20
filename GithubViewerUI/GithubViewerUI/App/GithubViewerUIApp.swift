import SwiftUI
import ComposableArchitecture
import GithubViewerNetworking
import GithubViewerDomain

@main
struct GithubViewerUIApp: App {
  var body: some Scene {
    WindowGroup {
      RepositoriesView(
        store: Store(
          initialState: RepositoriesReducer.State(),
          reducer: RepositoriesReducer()
        )
      )
    }
  }
}
