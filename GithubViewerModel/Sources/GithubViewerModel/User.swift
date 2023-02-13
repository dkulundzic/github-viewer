import Foundation

public struct User: Decodable {
  public let id: Int
  public let name: String
  public let image: URL

  private enum CodingKeys: String, CodingKey {
    case id
    case name = "login"
    case image = "avatar_url"
  }
}

extension User: Hashable {
  public static func ==(lhs: User, rhs: User) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension User: Mockable {
  public static var mock: User {
    .init(
      id: (0...10000000).randomElement()!,
      name: "kriskowal",
      image: URL(string: "https://avatars.githubusercontent.com/u/60294?v=4")!
    )
  }
}
