import Foundation

struct SnowmanResponse: Codable {

    let latitude: Double
    let longitude: Double

    let forecast: WeatherForecast
    let dataSourceName: Preferences.DataSource

}
