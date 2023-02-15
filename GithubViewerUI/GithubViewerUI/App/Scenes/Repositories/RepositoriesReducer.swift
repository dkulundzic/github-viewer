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
    case firstAppear
    case onSearchTextChanged(String)
    case onRepositoriesLoaded([Repository])
    case onMenuActionTap(RepositorySortingOption)
  }

  func reduce(
    into state: inout RepositoriesState,
    action: RepositoriesAction
  ) -> EffectTask<RepositoriesAction> {
    switch action {
    case .firstAppear:
      state.isLoading = true
      return .task { [refQuery = state.refQuery] in
        return await .onRepositoriesLoaded(
          try self.repositoriesNetworkService.fetchRepositories(withQuery: refQuery)
        )
      }
    case .onSearchTextChanged(let text):
      struct SearchDebounceID: Hashable { }

      state.query = text
      return .task { [refQuery = state.refQuery] in
        return await .onRepositoriesLoaded(
          try self.repositoriesNetworkService.fetchRepositories(withQuery: refQuery)
        )
      }
      .debounce(id: SearchDebounceID(), for: 0.5, scheduler: DispatchQueue.main)
    case .onMenuActionTap(let option):
      state.selectedSortOption = option == state.selectedSortOption ? nil : option
      state.repositories = state.originalRepositories.sorted(using: state.selectedSortOption)
      return .none
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
