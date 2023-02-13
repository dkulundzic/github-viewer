import Foundation

public struct Repository: Decodable, Identifiable {
  public struct Author: Decodable {
    public let id: Int
    public let name: String?
    public let image: URL

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case image = "avatar_url"
    }
  }

  public var thumbnail: URL {
    author.image
  }

  public let id: Int
  public let name: String
  public let author: Author
  public let numOfWatchers: Int
  public let numOfForks: Int
  public let numOfIssues: Int

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case author = "owner"
    case numOfWatchers = "watchers_count"
    case numOfForks = "forks_count"
    case numOfIssues = "open_issues_count"
  }
}

extension Repository: Mockable {
  public static var mock: Repository {
    Repository(
      id: (0...10000000).randomElement()!,
      name: "Test Repository",
      author: .mock,
      numOfWatchers: (0...1000).randomElement()!,
      numOfForks: (0...10).randomElement()!,
      numOfIssues: (0...50).randomElement()!
    )
  }
}

extension Repository.Author: Mockable {
  public static var mock: Repository.Author {
    .init(
      id: (0...10000000).randomElement()!,
      name: "kriskowal",
      image: URL(string: "https://avatars.githubusercontent.com/u/60294?v=4")!
    )
  }
}
