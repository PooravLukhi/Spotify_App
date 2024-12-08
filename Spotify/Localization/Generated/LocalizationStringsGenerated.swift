// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  internal enum Common {
    internal enum Action {
      /// Delete
      internal static let delete = Localization.tr("Localization", "common.action.delete", fallback: "Delete")
      /// Ok
      internal static let ok = Localization.tr("Localization", "common.action.ok", fallback: "Ok")
    }
    internal enum Message {
      /// No music selected yet. Tap the '+' icon to add new tracks!
      internal static let emptyMusicTracks = Localization.tr("Localization", "common.message.emptyMusicTracks", fallback: "No music selected yet. Tap the '+' icon to add new tracks!")
      /// You don't have any playlists yet. Start by creating a new playlist—just tap the '+' icon!
      internal static let emptyPlaylists = Localization.tr("Localization", "common.message.emptyPlaylists", fallback: "You don't have any playlists yet. Start by creating a new playlist—just tap the '+' icon!")
      /// We couldn't find any results.
      /// Try searching for your favourite music or artists
      internal static let emptySearchResults = Localization.tr("Localization", "common.message.emptySearchResults", fallback: "We couldn't find any results.\nTry searching for your favourite music or artists")
      /// Error
      internal static let error = Localization.tr("Localization", "common.message.error", fallback: "Error")
      /// Search (minimum 2 characters)
      internal static let search = Localization.tr("Localization", "common.message.search", fallback: "Search (minimum 2 characters)")
    }
  }
  internal enum Dashboard {
    internal enum Home {
      /// Home
      internal static let title = Localization.tr("Localization", "dashboard.home.title", fallback: "Home")
    }
    internal enum Library {
      /// Your Library
      internal static let title = Localization.tr("Localization", "dashboard.library.title", fallback: "Your Library")
    }
    internal enum Search {
      /// Search
      internal static let title = Localization.tr("Localization", "dashboard.search.title", fallback: "Search")
    }
  }
  internal enum Library {
    internal enum Action {
      /// Cancel
      internal static let cancel = Localization.tr("Localization", "library.action.cancel", fallback: "Cancel")
    }
    internal enum Section {
      /// Playlists
      internal static let playlists = Localization.tr("Localization", "library.section.playlists", fallback: "Playlists")
      /// Songs
      internal static let songs = Localization.tr("Localization", "library.section.songs", fallback: "Songs")
    }
  }
  internal enum Playlist {
    /// Create a playlist with a song
    internal static let createPlaylistPrompt = Localization.tr("Localization", "playlist.createPlaylistPrompt", fallback: "Create a playlist with a song")
    /// Name your playlist.
    internal static let namePrompt = Localization.tr("Localization", "playlist.namePrompt", fallback: "Name your playlist.")
    internal enum Action {
      /// Confirm
      internal static let confirm = Localization.tr("Localization", "playlist.action.confirm", fallback: "Confirm")
    }
    internal enum Message {
      /// This is already added in %@
      internal static func alreadyAdded(_ p1: Any) -> String {
        return Localization.tr("Localization", "playlist.message.alreadyAdded", String(describing: p1), fallback: "This is already added in %@")
      }
    }
    internal enum Prompt {
      /// Enter your playlist name
      internal static let enterPlaylistName = Localization.tr("Localization", "playlist.prompt.enterPlaylistName", fallback: "Enter your playlist name")
    }
  }
  internal enum Services {
    internal enum Message {
      /// Something went wrong. Please check again.
      internal static let commonError = Localization.tr("Localization", "services.message.commonError", fallback: "Something went wrong. Please check again.")
      /// Please wait...
      internal static let wait = Localization.tr("Localization", "services.message.wait", fallback: "Please wait...")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
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
