import Foundation

extension DarkSkyResponse {

    struct DataPoint: Codable {

        let apparentTemperature: Double?
        let apparentTemperatureHigh: Double?
        let apparentTemperatureHighTime: Date?
        let apparentTemperatureLow: Double?
        let apparentTemperatureLowTime: Date?
        let apparentTemperatureMax: Double?
        let apparentTemperatureMaxTime: Date?
        let apparentTemperatureMin: Double?
        let apparentTemperatureMinTime: Date?
        let cloudCover: Double?
        let dewPoint: Double?
        let humidity: Double?
        let icon: String?
        let moonPhase: Double?
        let nearestStormBearing: Int?
        let nearestStormDisatnce: Int?
        let ozone: Double?
        let precipAccumulation: Double?
        let precipIntensity: Double?
        let precipIntensityError: Double?
        let precipIntensityMax: Double?
        let precipIntensityMaxTime: Date?
        let precipProbability: Double?
        let precipType: String?
        let pressure: Double?
        let summary: String?
        let sunriseTime: Date?
        let sunsetTime: Date?
        let temperature: Double?
        let temperatureHigh: Double?
        let temperatureHighTime: Date?
        let temperatureLow: Double?
        let temperatureLowTime: Date?
        let temperatureMax: Double?
        let temperatureMaxTime: Date?
        let temperatureMin: Double?
        let temperatureMinTime: Date?
        let time: Date
        let uvIndex: Int?
        let uvIndexTime: Date?
        let visibility: Double?
        let windBearing: Int?
        let windGust: Double?
        let windGustTime: Date?
        let windSpeed: Double?

    }

}
