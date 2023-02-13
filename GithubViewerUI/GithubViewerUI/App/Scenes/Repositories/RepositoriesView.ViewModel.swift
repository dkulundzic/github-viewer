import Foundation
import Combine
import GithubViewerModel
import GithubViewerNetworking

@MainActor final class RepositoriesViewModel: ObservableObject {
  @Published var repositories: [Repository] = []
  @Published var isLoading = false
  let repositoriesNetworkService: RepositoriesNetworkService
  private var bag = Set<AnyCancellable>()
  private let defaultQuery = "Test"
  private let searchQuerySubject = PassthroughSubject<String, Never>()

  init(repositoriesNetworkService: RepositoriesNetworkService) {
    self.repositoriesNetworkService = repositoriesNetworkService
    initializeObserving()
  }
}

extension RepositoriesViewModel {
  func loadRepositores(using query: String? = nil) async {
    isLoading = true
    defer { isLoading = false }

    do {
      let normalizedQuery = query ?? defaultQuery
      repositories = try await repositoriesNetworkService
        .fetchRepositories(withQuery: normalizedQuery)
    } catch {
      print(error)
    }
  }

  func onSearchQueryUpdated(_ query: String) {
    let newQuery = query.isEmpty ? defaultQuery : query
    let normalizedQuery = newQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    searchQuerySubject.send(normalizedQuery)
  }
}

private extension RepositoriesViewModel {
  func initializeObserving() {
    searchQuerySubject
      .removeDuplicates()
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .sink { query in
        print("New load request for \"\(query)\"")
        Task { await self.loadRepositores(using: query) }
      }
      .store(in: &bag)
  }
}
