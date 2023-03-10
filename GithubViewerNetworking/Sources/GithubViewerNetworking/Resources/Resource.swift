import Foundation

protocol Resource {
  var url: URL { get }
  var endpoint: String { get }
  var queryItems: [URLQueryItem]? { get }
}

extension Resource {
  var url: URL {
    let baseUrl = Host.baseUrl.appendingPathComponent(endpoint)

    guard
      let queryItems = queryItems,
      var comp = URLComponents(string: baseUrl.absoluteString),
      !queryItems.isEmpty else {
      return baseUrl
    }

    comp.queryItems = queryItems
    return comp.url ?? baseUrl
  }

  var queryItems: [URLQueryItem]? {
    nil
  }
}
