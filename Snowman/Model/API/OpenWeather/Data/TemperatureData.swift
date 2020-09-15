import Foundation

extension OpenWeatherResponse {

    struct TemperatureData: Codable {

        let morn: Double
        let day: Double
        let eve: Double
        let night: Double
        let min: Double
        let max: Double

    }

}
