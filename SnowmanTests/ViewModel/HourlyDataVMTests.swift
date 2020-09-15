import XCTest
@testable import Snowman

final class HourlyDataVMTests: XCTestCase {
    
    func testPropertiesCorrectlyFormatted() {
        let time = Date(timeIntervalSince1970: 449670896)
        let subject = HourlyDataViewModel(hour: .stub(date: time,
                                                      temperature: 1.0,
                                                      apparentTemperature: 1.0,
                                                      icon: .init(description: .cloudy, daytime: true),
                                                      precipProbability: 0.5))
        XCTAssertEqual(subject.time, "14")
        XCTAssertEqual(subject.temperature, "1°")
        XCTAssertEqual(subject.apparentTemperature, "1°")
        XCTAssertEqual(subject.icon.description, .cloudy)
        XCTAssertEqual(subject.icon.daytime, true)
        XCTAssertEqual(subject.precipProbability, "50%")
    }
    
    func testNumbersCorrectlyRoundedUp() {
        let subject = HourlyDataViewModel(hour: .stub(temperature: 1.5,
                                                      apparentTemperature: 1.5,
                                                      precipProbability: 0.999))
        XCTAssertEqual(subject.temperature, "2°")
        XCTAssertEqual(subject.apparentTemperature, "2°")
        XCTAssertEqual(subject.precipProbability, "100%")
    }
    
    func testNumbersCorrectlyRoundedDown() {
        let subject = HourlyDataViewModel(hour: .stub(temperature: 1.49,
                                                      apparentTemperature: 1.49,
                                                      precipProbability: 0.991))
        XCTAssertEqual(subject.temperature, "1°")
        XCTAssertEqual(subject.apparentTemperature, "1°")
        XCTAssertEqual(subject.precipProbability, "99%")
    }
    
    func testPrecipProbabilityNotShownIfZero() {
        let subject = HourlyDataViewModel(hour: .stub(precipProbability: 0.0))
        XCTAssertEqual(subject.precipProbability, "")
    }
    
    func testPrecipProbabilityNotShownIfBelowOnePercent() {
        let subject = HourlyDataViewModel(hour: .stub(precipProbability: 0.009999))
        XCTAssertEqual(subject.precipProbability, "")
    }
    
    func testPrecipProbabilityShownIfAtLeastOnePercent() {
        let subject = HourlyDataViewModel(hour: .stub(precipProbability: 0.01))
        XCTAssertEqual(subject.precipProbability, "1%")
    }
    
    func testCurrentWeatherLabeledNow() {
        let subject = HourlyDataViewModel(hour: .stub(date: Date()))
        XCTAssertEqual(subject.time, "now")
    }
    
}
