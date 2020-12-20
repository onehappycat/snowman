import SwiftUI

struct SFSymbolsTheme: ThemeProtocol {

    var isUsingSFSymbols = true
    
    func iconAsset(for status: WeatherStatus) -> String {
        switch status.description {
        case .clearSky:
            return status.daytime ? "sun.max.fill" : "moon.fill"
        case .partlyCloudy:
            return status.daytime ? "cloud.sun.fill" : "cloud.moon.fill"
        case .cloudy:
            return "cloud.fill"
        case .fog:
            return "cloud.fog.fill"
        case .rain:
            return "cloud.rain.fill"
        case .thunderstorm:
            return "cloud.bolt.fill"
        case .snow:
            return "snow"
        case .sleet:
            return "cloud.sleet"
        case .wind:
            return "wind"
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
