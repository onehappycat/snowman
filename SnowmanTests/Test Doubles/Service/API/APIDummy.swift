import XCTest
@testable import Snowman

final class APIDummy: APIServiceProtocol {

    func getForecast(for location: Location, in units: Preferences.Units, completion: @escaping (Result<WeatherForecast, SnowmanError>) -> Void) {
        // Does nothing
    }

    func searchLocations(_ query: String, completion: @escaping (Result<[Location], SnowmanError>) -> Void) {
        // Does nothing
    }

}
