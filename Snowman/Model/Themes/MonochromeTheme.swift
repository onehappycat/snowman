import SwiftUI

struct MonochromeTheme: ThemeProtocol {

    func iconAsset(for status: WeatherStatus) -> String {
        switch status.description {
        case .clearSky:
            return status.daytime ? "monochrome-sun" : "monochrome-moon"
        case .cloudy, .partlyCloudy, .fog:
            return "monochrome-cloud"
        case .rain:
            return "monochrome-cloud-rain"
        case .thunderstorm:
            return "monochrome-cloud-storm"
        case .snow:
            return "monochrome-snowflake"
        case .sleet:
            return "monochrome-cloud-snow"
        case .wind:
            return "monochrome-wind"
        }
    }

    func backgroundColor(for status: WeatherStatus) -> Color {
        switch status.description {
        case .clearSky:
            return status.daytime ? .skyClear : .skyClearNight
        case .partlyCloudy, .wind:
            return status.daytime ? .skyPartlyCloudy : .skyPartlyCloudyNight
        case .cloudy, .fog:
            return status.daytime ? .skyCloudy : .skyCloudyNight
        case .rain, .thunderstorm, .snow, .sleet:
            return status.daytime ? .skyRain : .skyCloudyNight
        }
    }

}
