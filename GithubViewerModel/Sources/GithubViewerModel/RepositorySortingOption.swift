import Foundation

public enum RepositorySortingOption: String, CaseIterable, Identifiable {
  case stars
  case forks
  case updated

  public var id: Self {
    self
  }
}
