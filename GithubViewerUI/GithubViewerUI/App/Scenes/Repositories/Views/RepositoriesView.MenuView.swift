import SwiftUI
import GithubViewerModel

extension RepositoriesView {
  struct MenuView: View {
    let options: [RepositorySortingOption]
    let selectedSortOption: RepositorySortingOption?
    let onOptionTap: (RepositorySortingOption) -> Void

    var body: some View {
      Menu {
        ForEach(options) { option in
          Button {
            onOptionTap(option)
          } label: {
            HStack {
              if option == selectedSortOption {
                Image(systemName: "checkmark")
              }
              Text(option.title)
            }
          }
        }
      } label: {
        Image(systemName: "arrow.up.arrow.down")
          .foregroundColor(.black)
      }
    }
  }
}

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesView.MenuView(
      options: RepositorySortingOption.allCases,
      selectedSortOption: .stars
    ) { _ in }
  }
}
