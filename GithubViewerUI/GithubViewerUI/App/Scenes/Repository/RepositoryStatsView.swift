import SwiftUI

struct RepositoryStatsView: View {
  let watchers: Int
  let stars: Int
  let issues: Int
  let forks: Int

  var body: some View {
    HStack(alignment: .center) {
      IconLabel(
        icon: Image(systemName: "star.fill"),
        iconColor: .yellow,
        title: stars.description
      )
      Spacer()

      IconLabel(
        icon: Image(systemName: "eye"),
        iconColor: .purple,
        title: watchers.description
      )
      Spacer()

      IconLabel(
        icon: Image(systemName: "exclamationmark.circle"),
        iconColor: .gray,
        title: issues.description
      )
      Spacer()

      IconLabel(
        icon: Image(systemName: "tuningfork"),
        iconColor: .gray,
        title: forks.description
      )
    }
  }
}

struct RepositoryDetailsStatsView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryStatsView(
      watchers: 51000,
      stars: 301,
      issues: 7,
      forks: 5
    )
  }
}
