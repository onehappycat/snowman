import Foundation

extension OpenWeatherResponse {

    struct FeelsLikeData: Codable {

        let morn: Double
        let day: Double
        let eve: Double
        let night: Double

    }

}
