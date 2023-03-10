// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// An error occurred
  internal static let repositoriesListErrorMessage = L10n.tr("Localizable", "repositories_list_error_message", fallback: "An error occurred")
  /// No repositories available
  internal static let repositoriesListNoReposAvailableMessage = L10n.tr("Localizable", "repositories_list_no_repos_available_message", fallback: "No repositories available")
  /// No description provided
  internal static let repositoryDescriptionPlaceholder = L10n.tr("Localizable", "repository_description_placeholder", fallback: "No description provided")
  /// Not available
  internal static let repositoryLanguagePlaceholder = L10n.tr("Localizable", "repository_language_placeholder", fallback: "Not available")
  /// Private
  internal static let repositoryVisibilityPrivate = L10n.tr("Localizable", "repository_visibility_private", fallback: "Private")
  /// Public
  internal static let repositoryVisibilityPublic = L10n.tr("Localizable", "repository_visibility_public", fallback: "Public")
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
