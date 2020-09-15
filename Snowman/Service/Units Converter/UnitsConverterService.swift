import Foundation

final class UnitsConverterService: UnitsConverterServiceProtocol {

    // MARK: UnitsConverterServiceProtocol

    func convert(_ forecast: WeatherForecast, to preferencesUnit: Preferences.Units, completion: @escaping (WeatherForecast) -> Void) {
        let currently = convert(forecast.currently, to: preferencesUnit)
        let hourly = forecast.hourly.map { convert($0, to: preferencesUnit) }
        let daily = forecast.daily.map { convert($0, to: preferencesUnit) }

        completion(WeatherForecast(currently: currently, hourly: hourly, daily: daily))
    }

    // MARK: - Private

    private func convertedValue(of input: Double, from baseUnit: UnitTemperature, to resultUnit: UnitTemperature) -> Double {
        Measurement(value: input, unit: baseUnit).converted(to: resultUnit).value
    }

    private func translateUnits(from units: Preferences.Units) -> UnitTemperature {
        switch units {
        case .si:
            return .celsius
        case .us:
            return .fahrenheit
        }
    }

    private func convert(_ hourlyData: WeatherForecast.HourlyData, to preferencesUnit: Preferences.Units) -> WeatherForecast.HourlyData {
        let baseUnit = translateUnits(from: hourlyData.units)
        let resultUnit = translateUnits(from: preferencesUnit)

        let temperature = convertedValue(of: hourlyData.temperature, from: baseUnit, to: resultUnit)
        let apparentTemperature = convertedValue(of: hourlyData.apparentTemperature, from: baseUnit, to: resultUnit)

        return WeatherForecast.HourlyData(date: hourlyData.date,
                                          timezone: hourlyData.timezone,
                                          units: preferencesUnit,
                                          temperature: temperature,
                                          apparentTemperature: apparentTemperature,
                                          icon: hourlyData.icon,
                                          precipProbability: hourlyData.precipProbability)
    }

    private func convert(_ dailyData: WeatherForecast.DailyData, to preferencesUnit: Preferences.Units) -> WeatherForecast.DailyData {
        let baseUnit = translateUnits(from: dailyData.units)
        let resultUnit = translateUnits(from: preferencesUnit)

        let temperatureHigh = convertedValue(of: dailyData.temperatureHigh, from: baseUnit, to: resultUnit)
        let temperatureLow = convertedValue(of: dailyData.temperatureLow, from: baseUnit, to: resultUnit)

        return WeatherForecast.DailyData(date: dailyData.date,
                                         timezone: dailyData.timezone,
                                          units: preferencesUnit,
                                          temperatureHigh: temperatureHigh,
                                          temperatureLow: temperatureLow,
                                          icon: dailyData.icon,
                                          precipProbability: dailyData.precipProbability)
    }

}
