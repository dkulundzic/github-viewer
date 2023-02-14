import Foundation
import GithubViewerModel

@MainActor final class RepositoryDetailsViewModel: ObservableObject {
  @Published var details: RepositoryDetails
  private let repository: Repository

  init(repository: Repository) {
    self.repository = repository
    self.details = RepositoryDetails(repository: repository)
  }
}

extension RepositoryDetailsViewModel {
  struct RepositoryDetails {
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
}
