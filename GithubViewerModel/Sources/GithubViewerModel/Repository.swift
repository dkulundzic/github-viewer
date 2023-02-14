import Foundation

public struct Repository: Decodable, Identifiable {
  public var thumbnail: URL {
    user.image
  }

  public let id: Int
  public let name: String
  public let description: String?
  public let language: String
  public let updated: Date
  public let url: URL
  public let user: User
  public let numOfWatchers: Int
  public let numOfForks: Int
  public let numOfIssues: Int
  public let numOfStars: Int

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case language
    case updated = "updated_at"
    case url = "html_url"
    case user = "owner"
    case numOfWatchers = "watchers_count"
    case numOfForks = "forks_count"
    case numOfIssues = "open_issues_count"
    case numOfStars = "stargazers_count"
  }
}

extension Repository: Hashable {
  public static func ==(lhs: Repository, rhs: Repository) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension Repository: Mockable {
  public static var mock: Repository {
    Repository(
      id: (0...10000000).randomElement()!,
      name: "Test Repository",
      description: "Apache JMeter open-source load testing tool for analyzing and measuring the performance of a variety of services",
      language: "swift",
      updated: Date(),
      url: URL(string: "https://github.com/dkulundzic/github-viewer")!,
      user: .mock,
      numOfWatchers: (0...1000).randomElement()!,
      numOfForks: (0...10).randomElement()!,
      numOfIssues: (0...50).randomElement()!,
      numOfStars: (0...100000).randomElement()!
    )
  }
}
