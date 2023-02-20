import Foundation

enum Environment {
  case develop
  case production
  case staging

  static var current: Environment {
#if DEV
    return .develop
#elseif STAGING
    return .staging
#elseif PRODUCTION
    return .production
#else
    return .develop
#endif
  }
}

extension Environment {
  static var isDevelopment: Bool { current == .develop }
  static var isProduction: Bool { current == .production }
  static var isStaging: Bool { current == .staging }
  static var isUnitTest: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
  }
}
