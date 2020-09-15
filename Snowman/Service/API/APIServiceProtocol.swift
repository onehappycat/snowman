import Foundation

protocol APIServiceProtocol {

    func getForecast(for location: Location, in units: Preferences.Units, completion: @escaping (Result<WeatherForecast, SnowmanError>) -> Void)
    func searchLocations(_ query: String, completion: @escaping (Result<[Location], SnowmanError>) -> Void)

}
