import Foundation
import ComposableArchitecture
import GithubViewerModel

final class RepositoryReducer: ReducerProtocol {
  struct State: Equatable {
    let description: String
    let language: String
    let visibility: String
    let lastUpdated: String
    let repository: Repository
    let user: User

    init(repository: Repository) {
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

  enum Action { }

  func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
