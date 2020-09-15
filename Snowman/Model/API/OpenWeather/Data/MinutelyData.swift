import Foundation

extension OpenWeatherResponse {

    struct MinutelyData: Codable {

        let dt: Date
        let precipitation: Double

    }

}
