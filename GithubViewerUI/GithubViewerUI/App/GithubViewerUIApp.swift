import SwiftUI
import GithubViewerNetworking
import ComposableArchitecture

typealias Action = () -> Void
typealias ParameterizedAction<T> = (T) -> Void

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
