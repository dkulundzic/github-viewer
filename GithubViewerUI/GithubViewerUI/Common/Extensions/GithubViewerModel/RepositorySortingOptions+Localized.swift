import GithubViewerModel

extension RepositorySortingOption {
  var title: String {
    switch self {
    case .stars:
      return L10n.repositoriesListSortingStars
    case .forks:
      return L10n.repositoriesListSortingForks
    case .updated:
      return L10n.repositoriesListSortingUpdated
    }
  }
}
