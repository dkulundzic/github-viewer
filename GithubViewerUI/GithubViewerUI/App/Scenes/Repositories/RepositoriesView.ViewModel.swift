import Foundation
import GithubViewerModel
import GithubViewerNetworking

extension RepositoriesView {
  @MainActor final class ViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    let repositoriesNetworkService: RepositoriesNetworkService

    init(repositoriesNetworkService: RepositoriesNetworkService) {
      self.repositoriesNetworkService = repositoriesNetworkService
    }

    func loadRepositores() async {
      do {
        repositories = try await repositoriesNetworkService.fetchRepositories(withQuery: "Q")
      } catch {
        print(error)
      }
    }
  }
}
