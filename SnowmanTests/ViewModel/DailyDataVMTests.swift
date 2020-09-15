import XCTest
@testable import Snowman

final class DailyDataVMTests: XCTestCase {

    func testPropertiesCorrectlyFormatted() {
        let time = Date(timeIntervalSince1970: 449670896)
        let subject = DailyDataViewModel(day: .stub(date: time,
                                                    temperatureHigh: 1.0,
                                                    temperatureLow: 1.0,
                                                    icon: .init(description: .cloudy, daytime: true),
                                                    precipProbability: 0.5))
        XCTAssertEqual(subject.name, "Sunday")
        XCTAssertEqual(subject.temperatureHigh, "1°")
        XCTAssertEqual(subject.temperatureLow, "1°")
        XCTAssertEqual(subject.icon.description, .cloudy)
        XCTAssertEqual(subject.icon.daytime, true)
        XCTAssertEqual(subject.precipProbability, "50%")
    }
    
    func testNumbersCorrectlyRoundedUp() {
        let subject = DailyDataViewModel(day: .stub(temperatureHigh: 1.5,
                                                    temperatureLow: 1.5,
                                                    precipProbability: 0.999))
        XCTAssertEqual(subject.temperatureHigh, "2°")
        XCTAssertEqual(subject.temperatureLow, "2°")
        XCTAssertEqual(subject.precipProbability, "100%")
    }
    
    func testNumbersCorrectlyRoundedDown() {
        let subject = DailyDataViewModel(day: .stub(temperatureHigh: 1.49,
                                                    temperatureLow: 1.49,
                                                    precipProbability: 0.99))
        XCTAssertEqual(subject.temperatureHigh, "1°")
        XCTAssertEqual(subject.temperatureLow, "1°")
        XCTAssertEqual(subject.precipProbability, "99%")
    }
    
    func testPrecipProbabilityNotShownIfZero() {
        let subject = DailyDataViewModel(day: .stub(precipProbability: 0.0))
        XCTAssert(subject.precipProbability.isEmpty)
    }
    
    func testPrecipProbabilityNotShownIfBelowOnePercent() {
        let subject = DailyDataViewModel(day: .stub(precipProbability: 0.009999))
        XCTAssert(subject.precipProbability.isEmpty)
    }
    
    func testPrecipProbabilityShownIfAtLeastOnePercent() {
        let subject = DailyDataViewModel(day: .stub(precipProbability: 0.01))
        XCTAssertEqual(subject.precipProbability, "1%")
    }
    
}
