import Foundation

enum RepositoriesResource: Resource {
  case search(query: String)

  var endpoint: String {
    switch self {
    case .search:
      return "search/repositories"
    }
  }

  var queryItems: [URLQueryItem]? {
    switch self {
    case .search(let query):
      return [URLQueryItem(name: "q", value: query)]
    }
  }
}
