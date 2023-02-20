import ComposableArchitecture
import GithubViewerNetworking

private enum RepositoriesNetworkServiceKey: DependencyKey {
  static let liveValue: RepositoriesNetworkService = DefaultRepositoriesNetworkService()
  static let testValue: RepositoriesNetworkService = TestRepositoriesNetworkService()
}

extension DependencyValues {
  var repositoriesNetworkService: RepositoriesNetworkService {
    get { self[RepositoriesNetworkServiceKey.self] }
    set { self[RepositoriesNetworkServiceKey.self] = newValue }
  }
}
