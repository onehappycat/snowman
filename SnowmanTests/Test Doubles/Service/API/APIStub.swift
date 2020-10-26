import XCTest
@testable import Snowman

final class APIStub: APIServiceProtocol {

    private let forecastResult: Result<WeatherForecast, SnowmanError>!
    private let searchResult: Result<[Location], SnowmanError>!
    var dataSourceName: String? = "APIStub"

    // MARK: - Init

    init(forecast: WeatherForecast) {
        self.forecastResult = .success(forecast)
        self.searchResult = nil
    }

    init(locations: [Location]) {
        self.forecastResult = nil
        self.searchResult = .success(locations)
    }

    init(forecast: WeatherForecast, locations: [Location]) {
        self.forecastResult = .success(forecast)
        self.searchResult = .success(locations)
    }

    init(error: SnowmanError) {
        self.forecastResult = .failure(error)
        self.searchResult = .failure(error)
    }

    // MARK: - Methods

    func getForecast(for location: Location, in units: Preferences.Units, completion: @escaping (Result<WeatherForecast, SnowmanError>) -> Void) {
        completion(forecastResult)
    }

    func searchLocations(_ query: String, completion: @escaping (Result<[Location], SnowmanError>) -> Void) {
        completion(searchResult)
    }

}
