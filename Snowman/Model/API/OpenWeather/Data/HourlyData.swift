import Foundation

extension OpenWeatherResponse {

    struct HourlyData: Codable {

        let dt: Date
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let dew_point: Double
        let clouds: Int
        let visibility: Int?
        let wind_speed: Double
        let wind_gust: Double?
        let wind_deg: Int
        let pop: Double
        let rain: [String: Double]?
        let snow: [String: Double]?
        let weather: [WeatherData]

    }

}
