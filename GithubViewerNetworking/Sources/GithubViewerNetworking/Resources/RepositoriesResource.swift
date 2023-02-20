import Foundation
import GithubViewerModel

enum RepositoriesResource: Resource {
  private enum QueryKey: String {
    case query = "q"
    case sort
  }

  case search(query: String, sortOption: RepositorySortingOption?)

  var endpoint: String {
    switch self {
    case .search:
      return "search/repositories"
    }
  }

  var queryItems: [URLQueryItem]? {
    switch self {
    case .search(let query, let sortOption):
      return [
        URLQueryItem(name: QueryKey.query.rawValue, value: query),
        URLQueryItem(name: QueryKey.sort.rawValue, value: sortOption?.description)
      ]
    }
  }
}
