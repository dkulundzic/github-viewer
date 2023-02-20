import SwiftUI

enum PreviewDevice {
  enum Phone {
    static let iPhone8 = "iPhone 8"
    static let iPhone8Plus = "iPhone 8 Plus"
    static let iPhoneX = "iPhone X"
    static let iPhoneXs = "iPhone Xs"
    static let iPhoneXsMax = "iPhone Xs Max"
    static let iPhoneXr = "iPhone Xr"
    static let iPhoneSE = "iPhone SE (3rd generation)"
    static let iPhone11 = "iPhone 11"
    static let iPhone11Pro = "iPhone 11 Pro"
    static let iPhone11ProMax = "iPhone 11 Pro Max"
    static let iPhone12Mini = "iPhone 12 Mini"
    static let iPhone12 = "iPhone 12"
    static let iPhone12Pro = "iPhone 12 Pro"
    static let iPhone12ProMax = "iPhone 12 Pro Max"
    static let iPhone13Mini = "iPhone 13 Mini"
    static let iPhone13 = "iPhone 13"
    static let iPhone13Pro = "iPhone 13 Pro"
    static let iPhone13ProMax = "iPhone 13 Pro Max"
    static let iPhone14 = "iPhone 13"
    static let iPhone14Pro = "iPhone 13 Pro"
    static let iPhone14ProMax = "iPhone 13 Pro Max"
  }

  enum Tablet {
    static let iPad = "iPad (9th generation)"
    static let iPadAir = "iPad Air (5th generation)"
    static let iPadMini = "iPad mini (6th generation)"
    static let iPadPro11 = "iPad Pro (11-inch) (3rd generation)"
    static let iPadPro129 = "iPad Pro (12.9-inch) (5th generation)"
  }

  @available(*, unavailable, message: "Available when Watch support is added.")
  enum Watch {
    static let series338mm = "Apple Watch Series 3 - 38mm"
    static let series342mm = "Apple Watch Series 3 - 42mm"
    static let series640mm = "Apple Watch Series 6 - 40mm"
    static let series644mm = "Apple Watch Series 6 - 44mm"
    static let series741mm = "Apple Watch Series 7 - 41mm"
    static let series745mm = "Apple Watch Series 7 - 45mm"
  }
}
