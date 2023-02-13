import Foundation

public enum RepositorySortingOption: Int, CaseIterable, Identifiable {
  case stars = 0
  case forks
  case updated

  public static var sorted: [RepositorySortingOption] {
    allCases.sorted(by: { $0.rawValue > $1.rawValue })
  }

  public var id: Self {
    self
  }
}
