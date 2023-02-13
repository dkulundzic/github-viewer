import Foundation

public enum RepositorySortingOption: Int, CaseIterable, Identifiable {
  case stars = 0
  case forks
  case updated

  public var id: Self {
    self
  }
}
