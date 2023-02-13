import Foundation
import GithubViewerModel
import GithubViewerNetworking

extension RepositoriesView {
  @MainActor final class ViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    @Published var isLoading = false
    let repositoriesNetworkService: RepositoriesNetworkService

    init(repositoriesNetworkService: RepositoriesNetworkService) {
      self.repositoriesNetworkService = repositoriesNetworkService
    }

    func loadRepositores() async {
      isLoading = true
      defer { isLoading = false }

      do {
        repositories = try await repositoriesNetworkService.fetchRepositories(withQuery: "Q")
      } catch {
        print(error)
      }
    }
  }
}
