import Foundation

public struct Repository: Decodable, Identifiable {
  public var thumbnail: URL {
    user.image
  }

  public let id: Int
  public let name: String
  public let updated: Date
  public let user: User
  public let numOfWatchers: Int
  public let numOfForks: Int
  public let numOfIssues: Int
  public let numOfStars: Int

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case updated = "updated_at"
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
      updated: Date(),
      user: .mock,
      numOfWatchers: (0...1000).randomElement()!,
      numOfForks: (0...10).randomElement()!,
      numOfIssues: (0...50).randomElement()!,
      numOfStars: (0...100000).randomElement()!
    )
  }
}
