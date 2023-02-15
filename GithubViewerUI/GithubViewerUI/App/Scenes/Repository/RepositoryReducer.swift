import Foundation
import ComposableArchitecture
import GithubViewerModel

final class RepositoryReducer: ReducerProtocol {
  struct State: Equatable {
    let name: String
    let description: String
    let language: String
    let visibility: String
    let lastUpdated: String
    let url: URL
    let watchers: Int
    let stars: Int
    let issues: Int
    let forks: Int
    let userName: String
    let userImageUrl: URL
    let userUrl: URL

    init(repository: Repository) {
      self.name = repository.name
      #warning("TODO: Localise")
      self.description = repository.description ?? "No description provided"
      self.language = repository.language ?? "Not available"
      self.visibility = repository.isPrivate ? "Private" : "Public"
      self.lastUpdated = repository.updated.formatted(
        date: .abbreviated,
        time: .omitted
      )
      self.url = repository.url
      self.watchers = repository.numOfWatchers
      self.stars = repository.numOfStars
      self.issues = repository.numOfIssues
      self.forks = repository.numOfForks
      self.userName = repository.user.name
      self.userImageUrl = repository.user.image
      self.userUrl = repository.user.url
    }
  }

  enum Action { }

  func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
