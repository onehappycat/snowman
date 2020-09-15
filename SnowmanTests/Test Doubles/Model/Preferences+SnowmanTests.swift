import XCTest
@testable import Snowman

extension Preferences {

    static func stub(locations: [Location] = [],
                     units: Preferences.Units = .si,
                     backgroundColorTint: Preferences.BackgroundColorTint = .on,
                     theme: Preferences.Theme = .defaultTheme,
                     statusBarAppearance: Preferences.StatusBarAppearance = .appIcon) -> Preferences {

        Preferences(locations: locations,
                    units: units,
                    backgroundColorTint: backgroundColorTint,
                    theme: theme,
                    statusBarAppearance: statusBarAppearance)

    }

}
