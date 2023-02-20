import Foundation
import ComposableArchitecture
import GithubViewerModel

public final class RepositoryReducer: ReducerProtocol {
  public struct State: Equatable {
    public let description: String
    public let language: String
    public let visibility: String
    public let lastUpdated: String
    public let repository: Repository
    public let user: User

    public init(repository: Repository) {
      self.repository = repository
      self.user = repository.user
      self.description = repository.description ?? L10n.repositoryDescriptionPlaceholder
      self.language = repository.language ?? L10n.repositoryLanguagePlaceholder
      self.visibility = repository.isPrivate ? L10n.repositoryVisibilityPrivate : L10n.repositoryVisibilityPublic
      self.lastUpdated = repository.updated.formatted(
        date: .abbreviated,
        time: .omitted
      )
    }
  }

  public init() { }

  public enum Action { }

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
