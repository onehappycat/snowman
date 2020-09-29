import Foundation

struct Preferences: Codable {

    var locations: [Location]
    var units: Units
    var backgroundColorTint: BackgroundColorTint
    var theme: Theme
    var statusBarAppearance: StatusBarAppearance

}

extension Preferences {

    static var defaultValues: Preferences {
        Preferences(locations: [],
                    units: Locale.current.usesMetricSystem ? .si : .us,
                    backgroundColorTint: .on,
                    theme: .defaultTheme,
                    statusBarAppearance: .appIcon)
    }

}

extension Preferences {

    enum Units: String, Codable, PreferencesViewRepresentable {
        case si
        case us
    }

    enum BackgroundColorTint: String, Codable, PreferencesViewRepresentable {
        case on
        case off
    }

    enum Theme: String, Codable, PreferencesViewRepresentable {
        case defaultTheme
        case monochrome
    }

    enum StatusBarAppearance: String, Codable, PreferencesViewRepresentable {
        case appIcon
        case forecastFirst
        case forecastFull
    }

    enum DataSource: String, Codable {
        case DarkSky
        case OpenWeather
        case Snowman
    }

}
