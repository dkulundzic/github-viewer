import Foundation
import ComposableArchitecture
import GithubViewerModel

public final class RepositoriesReducer: ReducerProtocol {
  @Dependency(\.repositoriesNetworkService) private var repositoriesNetworkService
  @Dependency(\.mainQueue) private var queue

  public struct RepositoriesState: Equatable {
    public var query: String
    public var repositories: [Repository] = []
    public var originalRepositories: [Repository] = []
    public var isLoading = false
    public var infoMessage: String?
    public var selectedSortOption: RepositorySortingOption?
    public let sortOptions = RepositorySortingOption.sorted
    public let defaultQuery = "Kingfisher"

    public init(selectedSortOption: RepositorySortingOption? = nil) {
      self.selectedSortOption = selectedSortOption
      self.query = defaultQuery
    }

    public mutating func setQuery(_ query: String) {
      self.query = query.isEmpty ? defaultQuery : query
    }
  }

  public init() { }

  public enum RepositoriesAction: Equatable {
    case onFirstAppear
    case onSearchTextChanged(String)
    case onSearchTextDelayCompleted(String)
    case onMenuActionTap(RepositorySortingOption)
    case onLoadRepositories
    case onRepositoriesResponse(TaskResult<[Repository]>)
  }

  public func reduce(
    into state: inout RepositoriesState,
    action: RepositoriesAction
  ) -> EffectTask<RepositoriesAction> {
    switch action {
    case .onFirstAppear:
      return .send(.onLoadRepositories)

    case .onSearchTextChanged(let query):
      struct SearchDebounceID: Hashable { }

      return .task { .onSearchTextDelayCompleted(query) }
        .debounce(id: SearchDebounceID(), for: 0.5, scheduler: queue)

    case .onSearchTextDelayCompleted(let query):
      state.setQuery(query)
      return .send(.onLoadRepositories)

    case .onMenuActionTap(let option):
      state.selectedSortOption = option == state.selectedSortOption ? nil : option
      state.repositories = state.originalRepositories.sorted(using: state.selectedSortOption)
      return .send(.onLoadRepositories)

    case .onLoadRepositories:
      state.isLoading = true

      return .task { [query = state.query, sortOption = state.selectedSortOption] in
        await .onRepositoriesResponse(
          TaskResult {
            try await self.repositoriesNetworkService.fetchRepositories(
              withQuery: query, using: sortOption
            )
          }
        )
      }

    case .onRepositoriesResponse(.failure):
      state.infoMessage = L10n.repositoriesListErrorMessage
      state.isLoading = false
      state.originalRepositories = []
      state.repositories = []
      return .none

    case .onRepositoriesResponse(.success(let repositories)):
      state.infoMessage = repositories.isEmpty ? L10n.repositoriesListNoReposAvailableMessage : nil
      state.isLoading = false
      state.originalRepositories = repositories
      state.repositories = repositories.sorted(using: state.selectedSortOption)
      return .none
    }
  }
}

extension Array where Element == Repository {
  func sorted(using option: RepositorySortingOption?) -> Self {
    guard let option = option else {
      return self
    }

    return self.sorted { lhs, rhs in
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
