import Foundation

extension OpenWeatherResponse {

    struct DailyData: Codable {

        let dt: Date
        let sunrise: Date
        let sunset: Date
        let temp: TemperatureData
        let feels_like: FeelsLikeData
        let pressure: Int
        let humidity: Int
        let dew_point: Double
        let wind_speed: Double
        let wind_gust: Double?
        let wind_deg: Int
        let clouds: Int
        let uvi: Double?
        let visibility: Int?
        let pop: Double
        let rain: Double?
        let snow: Double?
        let weather: [WeatherData]

    }

}
