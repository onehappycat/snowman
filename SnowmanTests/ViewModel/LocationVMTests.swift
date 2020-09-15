import XCTest
@testable import Snowman

final class LocationVMTests: XCTestCase {

    // MARK: - name

    func testName() {
        let location = Location(geoData: .stub(name: "Name"))
        let subject = LocationViewModel(model: location)

        XCTAssertEqual(subject.name, "Name")
    }

    // MARK: - fullName

    func testFullName() {
        let location = Location(geoData: .stub(name: "Name",
                                               area: "Area",
                                               country: "Country"))
        let subject = LocationViewModel(model: location)

        XCTAssertEqual(subject.fullName, "Name, Area, Country")
    }

    // MARK: - country

    func testCountryOutputCorrectlyFormatted() {
        let location = Location(geoData: .stub(name: "Name",
                                               area: "Area",
                                               country: "Country"))
        let subject = LocationViewModel(model: location)

        XCTAssertEqual(subject.country, ", Area, Country")
    }

    func testLocationNameNotDuplicatedInCountry() {
        let location = Location(geoData: .stub(name: "Name",
                                               area: "Name",
                                               country: "Country"))
        let subject = LocationViewModel(model: location)

        XCTAssertEqual(subject.country, ", Country")
    }

    func testCountryNameNotDuplicated() {
        let location = Location(geoData: .stub(name: "Name",
                                               area: "Country",
                                               country: "Country"))
        let subject = LocationViewModel(model: location)

        XCTAssertEqual(subject.country, ", Country")
    }

    func testCountryStringEmptyIfItContainsNoAdditionalInformation() {
        let location = Location(geoData: .stub(name: "Name",
                                               area: "Name",
                                               country: "Name"))
        let subject = LocationViewModel(model: location)

        XCTAssert(subject.country.isEmpty)
    }

    func testCountryStringEmptyIfDataNotAvailable() {
        let location = Location(geoData: .stub(name: "Name",
                                               area: nil,
                                               country: nil))
        let subject = LocationViewModel(model: location)

        XCTAssert(subject.country.isEmpty)
    }

}
