import Foundation
import ComposableArchitecture
import GithubViewerModel

final class RepositoriesReducer: ReducerProtocol {
  @Dependency(\.repositoriesNetworkService) private var repositoriesNetworkService
  @Dependency(\.mainQueue) private var queue

  struct RepositoriesState: Equatable {
    var query: String = "Kingfisher"
    var repositories: [Repository] = []
    var originalRepositories: [Repository] = []
    var isLoading = false
    var selectedSortOption: RepositorySortingOption?
    let sortOptions = RepositorySortingOption.sorted

    init(selectedSortOption: RepositorySortingOption? = nil) {
      self.selectedSortOption = selectedSortOption
    }
  }

  enum RepositoriesAction: Equatable {
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
      return .send(.onLoadRepositories)

    case .onSearchTextChanged(let query):
      struct SearchDebounceID: Hashable { }
      return .task { .onSearchTextDelayCompleted(query) }
        .removeDuplicates()
        .eraseToEffect()
        .debounce(id: SearchDebounceID(), for: 0.5, scheduler: queue)

    case .onSearchTextDelayCompleted(let query):
      state.query = query
      return .send(.onLoadRepositories)

    case .onMenuActionTap(let option):
      state.selectedSortOption = option == state.selectedSortOption ? nil : option
      state.repositories = state.originalRepositories.sorted(using: state.selectedSortOption)
      return .none

    case .onLoadRepositories:
      guard !state.query.isEmpty else {
        return . none
      }

      state.isLoading = true

      return .task { [query = state.query] in
        return await .onRepositoriesLoaded(
          try self.repositoriesNetworkService.fetchRepositories(withQuery: query)
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
