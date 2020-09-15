import XCTest
@testable import Snowman

extension WeatherForecast {

    static var random: WeatherForecast {
        WeatherForecast(currently: .random,
                        hourly: [.random],
                        daily: [.random])
    }

}

extension WeatherForecast.HourlyData {

    static func stub(date: Date = Date(),
                     timezone: TimeZone = TimeZone.current,
                     units: Preferences.Units = .si,
                     temperature: Double = 0.0,
                     apparentTemperature: Double = 0.0,
                     icon: WeatherStatus = .init(description: .clearSky, daytime: true),
                     precipProbability: Double = 0.0) -> WeatherForecast.HourlyData {

        WeatherForecast.HourlyData(date: date,
                                   timezone: timezone,
                                   units: units,
                                   temperature: temperature,
                                   apparentTemperature: apparentTemperature,
                                   icon: icon,
                                   precipProbability: precipProbability)

    }

    static var random: WeatherForecast.HourlyData {
        WeatherForecast.HourlyData(date: Date(),
                                   timezone: TimeZone.current,
                                   units: .si,
                                   temperature: Double.random(in: -40...40),
                                   apparentTemperature: Double.random(in: -40...40),
                                   icon: .init(description: .clearSky, daytime: true),
                                   precipProbability: Double.random(in: 0...1))
    }

}

extension WeatherForecast.DailyData {

    static func stub(date: Date = Date(),
                     timezone: TimeZone = TimeZone.current,
                     units: Preferences.Units = .si,
                     temperatureHigh: Double = 0.0,
                     temperatureLow: Double = 0.0,
                     icon: WeatherStatus = .init(description: .clearSky, daytime: true),
                     precipProbability: Double = 0.0) -> WeatherForecast.DailyData {

        WeatherForecast.DailyData(date: date,
                                  timezone: timezone,
                                  units: units,
                                  temperatureHigh: temperatureHigh,
                                  temperatureLow: temperatureLow,
                                  icon: icon,
                                  precipProbability: precipProbability)

    }

    static var random: WeatherForecast.DailyData {
        WeatherForecast.DailyData(date: Date(),
                                  timezone: TimeZone.current,
                                  units: .si,
                                  temperatureHigh: 0.0,
                                  temperatureLow: 0.0,
                                  icon: .init(description: .clearSky, daytime: true),
                                  precipProbability: 0.0)
    }

}
