import Foundation
import Combine
import GithubViewerModel
import GithubViewerNetworking

@MainActor final class RepositoriesViewModel: ObservableObject {
  @Published var repositories: [Repository] = []
  @Published var sortOptions = RepositorySortingOption.sorted
  @Published var isLoading = false
  @Published var selectedSortOption: RepositorySortingOption?

  let repositoriesNetworkService: RepositoriesNetworkService
  private var originalRepositories: [Repository] = []
  private var bag = Set<AnyCancellable>()
  private var task: Task<Void, Never>?
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
      originalRepositories = try await repositoriesNetworkService
        .fetchRepositories(withQuery: normalizedQuery)
      repositories = sortedRepositories(using: selectedSortOption)
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
    repositories = sortedRepositories(using: selectedSortOption)
  }
}

private extension RepositoriesViewModel {
  func initializeObserving() {
    searchQuerySubject
      .removeDuplicates()
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .sink { [weak self] query in
        guard let self = self else { return }
        self.task?.cancel()
        self.task = Task { await self.loadRepositores(using: query) }
      }
      .store(in: &bag)
  }

  func sortedRepositories(using sortOption: RepositorySortingOption?) -> [Repository] {
    guard let option = sortOption else {
      return originalRepositories
    }

    return originalRepositories.sorted { lhs, rhs in
      switch option {
      case .forks:
        return lhs.numOfForks > rhs.numOfForks
      case .stars:
        return lhs.numOfStars > rhs.numOfStars
      case .updated:
        return lhs.updated > rhs.updated
      }
    }
  }
}
