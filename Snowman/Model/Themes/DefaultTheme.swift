import SwiftUI

struct DefaultTheme: ThemeProtocol {

    func iconAsset(for status: WeatherStatus) -> String {
        switch status.description {
        case .clearSky:
            return status.daytime ? "default-sun" : "default-moon"
        case .cloudy, .partlyCloudy, .fog:
            return "default-cloud"
        case .rain:
            return "default-cloud-rain"
        case .thunderstorm:
            return "default-cloud-storm"
        case .snow:
            return "default-snowflake"
        case .sleet:
            return "default-cloud-snow"
        case .wind:
            return "default-wind"
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
