import Foundation
import ComposableArchitecture
import GithubViewerModel

final class RepositoriesReducer: ReducerProtocol {
  @Dependency(\.repositoriesNetworkService) private var repositoriesNetworkService

  struct RepositoriesState: Equatable {
    var refQuery: String {
      query ?? defaultQuery
    }

    var query: String?
    var repositories: [Repository] = []
    var originalRepositories: [Repository] = []
    var isLoading = false
    var selectedSortOption: RepositorySortingOption?
    let sortOptions = RepositorySortingOption.sorted
    let defaultQuery = "Test"

    init(selectedSortOption: RepositorySortingOption? = nil) {
      self.selectedSortOption = selectedSortOption
    }
  }

  enum RepositoriesAction {
    case onFirstAppear
    case onSearchTextChanged(String)
    case onSearchTextDelayCompleted(String)
    case onMenuActionTap(RepositorySortingOption)
    case onLoadRepositories
    case onRepositoriesLoaded([Repository])
  }

  func reduce(
    into state: inout RepositoriesState,
    action: RepositoriesAction
  ) -> EffectTask<RepositoriesAction> {
    switch action {
    case .onFirstAppear:
      state.isLoading = true
      return .send(.onLoadRepositories)

    case .onSearchTextChanged(let text):
      struct SearchDebounceID: Hashable { }
      return .task { .onSearchTextDelayCompleted(text) }
        .debounce(id: SearchDebounceID(), for: 0.5, scheduler: DispatchQueue.main)

    case .onSearchTextDelayCompleted(let query):
      state.isLoading = true
      state.query = query
      return .send(.onLoadRepositories)

    case .onMenuActionTap(let option):
      state.selectedSortOption = option == state.selectedSortOption ? nil : option
      state.repositories = state.originalRepositories.sorted(using: state.selectedSortOption)
      return .none

    case .onLoadRepositories:
      return .task { [refQuery = state.refQuery] in
        return await .onRepositoriesLoaded(
          try self.repositoriesNetworkService.fetchRepositories(withQuery: refQuery)
        )
      }

    case .onRepositoriesLoaded(let repos):
      state.isLoading = false
      state.originalRepositories = repos
      state.repositories = repos.sorted(using: state.selectedSortOption)
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
