import Foundation
import Combine
import GithubViewerModel
import GithubViewerNetworking

@MainActor final class RepositoriesViewModel: ObservableObject {
  @Published var repositories: [Repository] = []
  @Published var sortOptions = RepositorySortingOption.allCases
  @Published var isLoading = false
  @Published var selectedSortOption: RepositorySortingOption?

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

  func onMenuActionTap(_ option: RepositorySortingOption) {
    selectedSortOption = option == selectedSortOption ? nil : option

    guard let sortOption = selectedSortOption else {
      return
    }

    repositories = repositories.sorted { lhs, rhs in
      switch sortOption {
      case .forks:
        return lhs.numOfForks > rhs.numOfForks
      case .stars:
        return lhs.numOfStars > rhs.numOfStars
      case .updated:
        return true
      }
    }
  }
}

private extension RepositoriesViewModel {
  func initializeObserving() {
    searchQuerySubject
      .removeDuplicates()
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .sink { query in
        Task { await self.loadRepositores(using: query) }
      }
      .store(in: &bag)
  }
}
