import SwiftUI
import GithubViewerModel
import GithubViewerNetworking

@main
struct GithubViewerUIApp: App {
  var body: some Scene {
    WindowGroup {
      RepositoriesView()
    }
  }
}
