import XCTest
import ComposableArchitecture
import GithubViewerModel
@testable import GithubViewerUI

@MainActor
final class RepositoriesTests: XCTestCase {
  func testLoadingOnFirstAppear() async {
    let reducer = RepositoriesReducer()
    let store = TestStore(
      initialState: RepositoriesReducer.State(),
      reducer: reducer
    )

    await store.send(.onFirstAppear)

    await store.receive(.onLoadRepositories) { $0.isLoading = true }

    await store.receive(.onRepositoriesLoaded([])) {
      $0.isLoading = false
    }
  }

  func testSortOptionSelection() async {
    let reducer = RepositoriesReducer()
    let store = TestStore(
      initialState: RepositoriesReducer.State(),
      reducer: reducer
    )

    let option: RepositorySortingOption = .forks
    await store.send(.onMenuActionTap(option)) {
      $0.selectedSortOption = option
    }

    await store.send(.onMenuActionTap(option)) {
      $0.selectedSortOption = nil
    }
  }

  func testRepositoriesFetchWhenRequested() async {
    let reducer = RepositoriesReducer()
    let store = TestStore(
      initialState: RepositoriesReducer.State(),
      reducer: reducer
    )

    await store.send(.onLoadRepositories) {
      $0.isLoading = true
    }

    await store.receive(.onRepositoriesLoaded([])) {
      $0.isLoading = false
    }
  }

  func testSearchTextDebouncing() async {
    
  }
}
