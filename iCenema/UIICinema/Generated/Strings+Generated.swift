// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum App {
    internal enum Signin {
      /// Enter Email
      internal static let emailTextFieldPlaceholder = L10n.tr("Localizable", "app.signin.EmailTextFieldPlaceholder", fallback: "Enter Email")
      /// Email
      internal static let emailTextFieldTitle = L10n.tr("Localizable", "app.signin.EmailTextFieldTitle", fallback: "Email")
      /// Enter Password
      internal static let passwordTextFieldPlaceholder = L10n.tr("Localizable", "app.signin.passwordTextFieldPlaceholder", fallback: "Enter Password")
      /// Password
      internal static let passwordTextFieldTitle = L10n.tr("Localizable", "app.signin.passwordTextFieldTitle", fallback: "Password")
      /// Sign In
      internal static let signInButton = L10n.tr("Localizable", "app.signin.signInButton", fallback: "Sign In")
    }
    internal enum Splash {
      /// Start
      internal static let button = L10n.tr("Localizable", "app.splash.Button", fallback: "Start")
      /// Simple way to manage your booing
      internal static let description = L10n.tr("Localizable", "app.splash.description", fallback: "Simple way to manage your booing")
      /// Get Cooking
      internal static let getCookies = L10n.tr("Localizable", "app.splash.getCookies", fallback: "Get Cooking")
      /// Localizable.strings
      ///   ICinema for cinema
      /// 
      ///   Created by Ahmed Yamany on 23/05/2023.
      internal static let title = L10n.tr("Localizable", "app.splash.title", fallback: "I Cinema")
    }
  }
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
