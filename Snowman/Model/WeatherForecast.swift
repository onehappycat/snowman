import Foundation

struct WeatherForecast: Codable {

    let currently: HourlyData
    let hourly: [HourlyData]
    let daily: [DailyData]

}

extension WeatherForecast {

    struct HourlyData: Codable {

        let date: Date
        let timezone: TimeZone
        let units: Preferences.Units
        let temperature: Double
        let apparentTemperature: Double
        let icon: WeatherStatus
        let precipProbability: Double

    }

    struct DailyData: Codable {

        let date: Date
        let timezone: TimeZone
        let units: Preferences.Units
        let temperatureHigh: Double
        let temperatureLow: Double
        let icon: WeatherStatus
        let precipProbability: Double

    }

}
