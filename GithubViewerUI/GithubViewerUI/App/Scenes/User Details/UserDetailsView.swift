import SwiftUI
import GithubViewerModel

struct UserDetailsView: View {
  let user: User

  var body: some View {
    Text("Test")
  }
}

struct UserDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    UserDetailsView(user: .mock)
  }
}
