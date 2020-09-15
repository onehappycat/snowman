import XCTest
@testable import Snowman

final class OpenWeatherAPITests: XCTestCase {

    private var subject: OpenWeatherAPI!

    override func setUp() {
        super.setUp()
        let data = SnowmanTests.load(fixture: "OpenWeatherResponse")
        subject = OpenWeatherAPI(key: "TEST", networking: NetworkingStub(result: data))
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    // MARK: - getForecast

    func testGetForecastCallsProvidedCompletionHandlerToUpdateLocationForecast() {
        var location = Location.random
        XCTAssertNil(location.forecast)

        subject.getForecast(for: location, in: .si) { result in
            location.forecast = try? result.get()
        }

        XCTAssertNotNil(location.forecast, "Expected to have forecast data from fixture provided to NetworkingStub")
    }

    func testGetForecastParsesDataCorrectly() {
        var forecast: WeatherForecast?
        subject.getForecast(for: Location.random, in: .si) { result in
            forecast = try? result.get()
        }

        XCTAssertNotNil(forecast, "Expected to have forecast data from fixture provided to NetworkingStub")
        XCTAssertEqual(forecast?.currently.date, Date(timeIntervalSince1970: 1596822571))
        XCTAssertEqual(forecast?.currently.timezone, TimeZone(identifier: "Europe/London"))
        XCTAssertEqual(forecast?.hourly.count, 48)
        XCTAssertEqual(forecast?.daily.count, 8)
        XCTAssertEqual(forecast?.currently.icon.description, .clearSky)
        XCTAssertEqual(forecast?.currently.icon.daytime, true)
        XCTAssertEqual(forecast?.currently.precipProbability, 0.0)
        XCTAssertEqual(forecast?.hourly[0].precipProbability, 0.0)
    }

    func testUnauthorized() {
        subject = OpenWeatherAPI(key: "TEST", networking: NetworkingStub(error: .responseUnauthorized))

        subject.getForecast(for: .random, in: .si) { result in
            switch result {
            case .success(_):
                XCTFail("Expected to receive Result.failure(_) from NetworkingStub")
            case .failure(let error):
                XCTAssertEqual(error, .responseUnauthorized)
            }
        }
    }

    func testWrongLocation() {
        subject = OpenWeatherAPI(key: "TEST", networking: NetworkingStub(error: .responseBadRequest))

        subject.getForecast(for: .random, in: .si) { result in
            switch result {
            case .success(_):
                XCTFail("Expected to receive Result.failure(_) from NetworkingStub")
            case .failure(let error):
                XCTAssertEqual(error, .responseBadRequest)
            }
        }
    }

    func testNetworkRequestFail() {
        subject = OpenWeatherAPI(key: "TEST", networking: NetworkingStub(error: .networkRequestFailed))

        subject.getForecast(for: .random, in: .si) { result in
            switch result {
            case .success(_):
                XCTFail("Expected to receive Result.failure(_) from NetworkingStub")
            case .failure(let error):
                XCTAssertEqual(error, .networkRequestFailed)
            }
        }
    }

    func testWrongFormat() {
        let response = SnowmanTests.load(fixture: "OpenWeatherWrongFormat")
        subject = OpenWeatherAPI(key: "TEST", networking: NetworkingStub(result: response))

        subject.getForecast(for: .random, in: .si) { result in
            switch result {
            case .success(_):
                XCTFail("Expected to not be able to decode the data")
            case .failure(let error):
                XCTAssertEqual(error, .apiDataDecoding)
            }
        }
    }

    func testMissingValues() {
        let response = SnowmanTests.load(fixture: "OpenWeatherMissingValues")
        subject = OpenWeatherAPI(key: "TEST", networking: NetworkingStub(result: response))

        subject.getForecast(for: .random, in: .si) { result in
            switch result {
            case .success(_):
                XCTFail("Expected to not be able to decode the data due to current[\"temp\"] missing")
            case .failure(let error):
                XCTAssertEqual(error, .apiDataDecoding)
            }
        }
    }

}
