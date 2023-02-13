// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// No repositories available
  internal static let repositoriesListNoReposAvailableMessage = L10n.tr("Localizable", "repositories_list_no_repos_available_message", fallback: "No repositories available")
  /// Forks
  internal static let repositoriesListSortingForks = L10n.tr("Localizable", "repositories_list_sorting_forks", fallback: "Forks")
  /// Stars
  internal static let repositoriesListSortingStars = L10n.tr("Localizable", "repositories_list_sorting_stars", fallback: "Stars")
  /// Updated
  internal static let repositoriesListSortingUpdated = L10n.tr("Localizable", "repositories_list_sorting_updated", fallback: "Updated")
  /// Repositories
  internal static let repositoriesListTitle = L10n.tr("Localizable", "repositories_list_title", fallback: "Repositories")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
