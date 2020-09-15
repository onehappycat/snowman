import Foundation

protocol UnitsConverterServiceProtocol {

    func convert(_ forecast: WeatherForecast, to units: Preferences.Units, completion: @escaping (WeatherForecast) -> Void)

}
