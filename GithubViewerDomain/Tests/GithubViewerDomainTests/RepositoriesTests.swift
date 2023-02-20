import XCTest
import ComposableArchitecture
import GithubViewerModel
import GithubViewerNetworking
@testable import GithubViewerDomain

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

    await store.receive(.onRepositoriesResponse(.success([]))) { $0.isLoading = false }
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

    await store.receive(.onRepositoriesResponse(.success([]))) { $0.isLoading = false }
  }

  func testSearchTextDebounced() async {
    let reducer = RepositoriesReducer()
    let store = TestStore(
      initialState: RepositoriesReducer.State(),
      reducer: reducer
    )

    let query = "Test"
    await store.send(.onSearchTextDelayCompleted(query)) {
      $0.query = query
    }

    await store.receive(.onLoadRepositories) {
      $0.isLoading = true
    }

    await store.receive(.onRepositoriesResponse(.success([]))) {
      $0.isLoading = false
    }
  }

  func testEmptySearchTextDebounced() async {
    let reducer = RepositoriesReducer()
    let store = TestStore(
      initialState: RepositoriesReducer.State(),
      reducer: reducer
    )

    let query = ""
    await store.send(.onSearchTextDelayCompleted(query)) {
      $0.query = query
    }

    await store.receive(.onLoadRepositories)
  }
}
