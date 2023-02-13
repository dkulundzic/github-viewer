import Foundation

public struct Repository: Decodable {
  public struct Author: Decodable {
    public let name: String
    public let image: URL
  }

  public var thumbnail: URL {
    author.image
  }

  public let name: String
  public let author: Author
  public let updated: Date
  public let numOfWatchers: Int
  public let numOfForks: Int
  public let numOfIssues: Int
}
