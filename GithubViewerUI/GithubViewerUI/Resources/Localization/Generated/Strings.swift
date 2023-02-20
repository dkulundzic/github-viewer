// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Forks
  internal static let repositoriesListSortingForks = L10n.tr("Localizable", "repositories_list_sorting_forks", fallback: "Forks")
  /// Stars
  internal static let repositoriesListSortingStars = L10n.tr("Localizable", "repositories_list_sorting_stars", fallback: "Stars")
  /// Updated
  internal static let repositoriesListSortingUpdated = L10n.tr("Localizable", "repositories_list_sorting_updated", fallback: "Updated")
  /// Repositories
  internal static let repositoriesListTitle = L10n.tr("Localizable", "repositories_list_title", fallback: "Repositories")
  /// Language
  internal static let repositoryLanguage = L10n.tr("Localizable", "repository_language", fallback: "Language")
  /// Last updated
  internal static let repositoryLastUpdated = L10n.tr("Localizable", "repository_last_updated", fallback: "Last updated")
  /// Owned by
  internal static let repositoryOwnedBy = L10n.tr("Localizable", "repository_owned_by", fallback: "Owned by")
  /// Visibility
  internal static let repositoryVisibility = L10n.tr("Localizable", "repository_visibility", fallback: "Visibility")
  /// See on the web
  internal static let repositoryWebPageCta = L10n.tr("Localizable", "repository_web_page_cta", fallback: "See on the web")
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
