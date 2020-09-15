import Foundation

struct WeatherStatus: Codable {

    let description: Description
    let daytime: Bool

}

extension WeatherStatus {

    enum Description: String, Codable {

        case clearSky
        case cloudy
        case partlyCloudy
        case rain
        case thunderstorm
        case snow
        case sleet
        case fog
        case wind

    }

}
