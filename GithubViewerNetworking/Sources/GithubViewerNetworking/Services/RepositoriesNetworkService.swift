import Foundation
import GithubViewerModel

public protocol RepositoriesNetworkService {
  func fetchRepositories(withQuery query: String) async throws -> [Repository]
}

public final class DefaultRepositoriesNetworkService: RepositoriesNetworkService {
  public init() { }
  
  public func fetchRepositories(withQuery query: String) async throws -> [Repository] {
    let resource = RepositoriesResource.search(query: query)
    print(#function, resource.url)
    let (data, _) = try await URLSession.shared.data(from: resource.url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decoder.decode(RepositoriesSearchResponse.self, from: data).items
  }
}

public final class TestRepositoriesNetworkService: RepositoriesNetworkService {
  public init() { }

  public func fetchRepositories(withQuery query: String) async throws -> [Repository] {
    []
  }
}
