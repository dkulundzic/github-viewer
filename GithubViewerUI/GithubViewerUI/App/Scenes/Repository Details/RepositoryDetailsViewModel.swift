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
    let repositoryName: String
    let repositoryDescription: String
    let repositoryLastUpdated: String
    let repositoryUrl: URL
    let userName: String
    let userImageUrl: URL
    let userUrl: URL

    init(repository: Repository) {
      self.repositoryName = repository.name
      #warning("TODO: Localise")
      self.repositoryDescription = repository.description ?? "No description provided"
      self.repositoryLastUpdated = repository.updated.formatted(
        date: .abbreviated,
        time: .omitted
      )
      self.repositoryUrl = repository.url
      self.userName = repository.user.name
      self.userImageUrl = repository.user.image
      self.userUrl = repository.user.url
    }
  }
}
