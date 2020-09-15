import Foundation

struct OpenWeatherResponse: Codable {

    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int

    let current: CurrentData
    // let minutely: [MinutelyData]
    let hourly: [HourlyData]
    let daily: [DailyData]

}
