import Foundation
import ComposableArchitecture
import GithubViewerModel

public final class UserReducer: ReducerProtocol {
  public struct State: Equatable {
    public let user: User

    public init(user: User) {
      self.user = user
    }
  }

  public init() { }

  public enum Action: Equatable { }

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
