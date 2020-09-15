import XCTest
@testable import Snowman

final class LocationListVMTests: XCTestCase {

    // MARK: - Subject

    var subject: LocationsListViewModel!
    var api: APIServiceProtocol!
    var persistance: PersistenceServiceProtocol!

    // MARK: - Setup and Teardown

    override func setUp() {
        super.setUp()
        api = APIDummy()
        persistance = PersistanceStub()
        subject = LocationsListViewModel(api: api, persistance: persistance)
    }

    override func tearDown() {
        subject = nil
        api = nil
        persistance = nil
        super.tearDown()
    }

    // MARK: - add

    func testAddChangesLocationsCount() {
        XCTAssertEqual(subject.locations.count, 0)
        subject.add(location: LocationViewModel(model: Location.random))
        XCTAssertEqual(subject.locations.count, 1)
    }

    func testAddLocationAddedToList() {
        let location = LocationViewModel(model: Location.random)
        subject.add(location: location)

        XCTAssertNotNil(subject.locations.firstIndex { $0 === location })
    }

    func testAddSavesLocationsToPersistance() {
        let model = Location.random
        subject.add(location: LocationViewModel(model: model))

        XCTAssertEqual(subject.preferences.locations.count, subject.locations.count)
        XCTAssertNotNil(subject.preferences.locations.first { location in
            location == model
        })
    }

    // MARK: - move

    func testMoveMovesTheLocationToDesiredIndex() {
        let location0 = LocationViewModel(model: Location.random)
        let location1 = LocationViewModel(model: Location.random)
        subject.add(location: location0)
        subject.add(location: location1)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location1 }, 1)

        subject.move(from: IndexSet(integer: 1), to: 0)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location1 }, 0)
    }

    func testMoveLocationsSubsequentFromTheNewIndexAreMovedBackByOne() {
        let location0 = LocationViewModel(model: Location.random)
        let location1 = LocationViewModel(model: Location.random)
        let location2 = LocationViewModel(model: Location.random)
        subject.add(location: location0)
        subject.add(location: location1)
        subject.add(location: location2)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location0 }, 0)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location1 }, 1)

        subject.move(from: IndexSet(integer: 2), to: 0)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location0 }, 1)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location1 }, 2)
    }

    func testMoveLocationsPrecedingTheNewIndexAreNotMoved() {
        let location0 = LocationViewModel(model: Location.random)
        let location1 = LocationViewModel(model: Location.random)
        let location2 = LocationViewModel(model: Location.random)
        subject.add(location: location0)
        subject.add(location: location1)
        subject.add(location: location2)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location0 }, 0)

        subject.move(from: IndexSet(integer: 2), to: 1)
        XCTAssertEqual(subject.locations.firstIndex { $0 === location0 }, 0)
    }

    func testMoveSavesChangesToPersistance() {
        subject.add(location: LocationViewModel(model: Location.random))

        let model = Location.random
        subject.add(location: LocationViewModel(model: model))

        XCTAssertEqual(subject.preferences.locations.firstIndex { location in
            location == model
        }, 1)

        subject.move(from: IndexSet(integer: 1), to: 0)
        
        XCTAssertEqual(subject.preferences.locations.firstIndex { location in
            location == model
        }, 0)
    }

    // MARK: - remove

    func testRemoveChangesLocationsCount() {
        let location0 = LocationViewModel(model: Location.random)
        let location1 = LocationViewModel(model: Location.random)
        subject.add(location: location0)
        subject.add(location: location1)
        XCTAssertEqual(subject.locations.count, 2)

        subject.remove(location0)
        XCTAssertEqual(subject.locations.count, 1)
    }

    func testRemoveLocationRemovedFromList() {
        let location0 = LocationViewModel(model: Location.random)
        let location1 = LocationViewModel(model: Location.random)
        subject.add(location: location0)
        subject.add(location: location1)
        XCTAssertNotNil(subject.locations.firstIndex { $0 === location0 })

        subject.remove(location0)
        XCTAssertNil(subject.locations.firstIndex { $0 === location0 })
    }

    func testRemoveSavesChangesToPersistance() {
        let model = Location.random
        let location = LocationViewModel(model: model)
        subject.add(location: location)
        subject.remove(location)

        XCTAssertEqual(subject.preferences.locations.count, subject.locations.count)
        XCTAssertNil(subject.preferences.locations.firstIndex { $0 == model })
    }

    // MARK: - General

    func testViewModelLoadsPreferencesFromPersistance() throws {
        XCTAssertEqual(subject.locations.count, 0)
        let model = Location.random
        persistance.save(Preferences.stub(locations: [model]))
        subject = LocationsListViewModel(api: api, persistance: persistance)

        XCTAssertEqual(subject.locations.count, 1)
        XCTAssertEqual(model, try XCTUnwrap(subject.locations.first?.location))
    }
    
    // MARK: - Title

    func testTitleWillNotBeEmptyWhenSetToFullForecastWithNoLocations() {
        XCTAssertEqual(subject.locations.count, 0)
        subject.preferences.statusBarAppearance = .forecastFull
        let title = subject.statusBarTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        XCTAssertFalse(title.isEmpty)
    }

    func testTitleWillNotBeEmptyWhenSetToFirstForecastWithNoLocations() {
        XCTAssertEqual(subject.locations.count, 0)
        subject.preferences.statusBarAppearance = .forecastFirst
        let title = subject.statusBarTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        XCTAssertFalse(title.isEmpty)
    }

    func testTitleWillNotBeEmptyWhenSetToAppIconWithNoLocations() {
        XCTAssertEqual(subject.locations.count, 0)
        subject.preferences.statusBarAppearance = .appIcon
        let title = subject.statusBarTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        XCTAssertFalse(title.isEmpty)
    }

    func testTitleWillHaveCorrectlyFormattedFullForecast() {
        let location0 = LocationViewModel(model: Location(geoData: .stub(), forecast: .random))
        let location1 = LocationViewModel(model: Location(geoData: .stub(), forecast: .random))
        subject.add(location: location0)
        subject.add(location: location1)
        subject.preferences.statusBarAppearance = .forecastFull

        let forecast = "\(location0.name): \(location0.currentForecast.temperature), \(location1.name): \(location1.currentForecast.temperature)"
        XCTAssertEqual(subject.statusBarTitle, forecast)
    }

    func testTitleWillHaveCorrectlyFormattedFirstForecast() {
        let location0 = LocationViewModel(model: Location(geoData: .stub(), forecast: .random))
        let location1 = LocationViewModel(model: Location(geoData: .stub(), forecast: .random))
        subject.add(location: location0)
        subject.add(location: location1)
        subject.preferences.statusBarAppearance = .forecastFirst

        let forecast = "\(location0.name): \(location0.currentForecast.temperature)"
        XCTAssertEqual(subject.statusBarTitle, forecast)
    }

    func testTitleHasRainIndicatorIfItIsRaining() {
        let forecast = WeatherForecast(currently: .stub(icon: .init(description: .rain, daytime: true)),
                                       hourly: [],
                                       daily: [])
        let location = LocationViewModel(model: Location(geoData: .stub(), forecast: forecast))
        subject.add(location: location)
        subject.preferences.statusBarAppearance = .forecastFirst

        XCTAssertEqual(subject.statusBarTitle, "\(location.name): \(location.currentForecast.temperature) ☂")
    }

    func testTitleHasRainIndicatorIfItIsAboutToRain() {
        let clear = WeatherForecast.HourlyData.stub(icon: .init(description: .clearSky, daytime: true))
        let rain = WeatherForecast.HourlyData.stub(icon: .init(description: .rain, daytime: true))

        let forecast = WeatherForecast(currently: clear, hourly: [clear, rain], daily: [])

        let location = LocationViewModel(model: Location(geoData: .stub(), forecast: forecast))
        subject.add(location: location)
        subject.preferences.statusBarAppearance = .forecastFirst

        XCTAssertEqual(subject.statusBarTitle, "\(location.name): \(location.currentForecast.temperature) ☂")
    }

}
