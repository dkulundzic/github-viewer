import SwiftUI

@main
struct GithubViewerUIApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        RepositoriesView()
      }
    }
  }
}
