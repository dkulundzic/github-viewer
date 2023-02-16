import Foundation
import ComposableArchitecture
import GithubViewerModel

final class UserReducer: ReducerProtocol {
  struct State: Equatable {
    let user: User
  }

  enum Action: Equatable { }

  func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
