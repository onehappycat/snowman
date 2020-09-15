import XCTest
@testable import Snowman

extension Location {

    static var random: Location {
        Location(geoData: .init(latitude: Double.random(in: -90...90),
                                longitude: Double.random(in: -180...180),
                                name: "\(Int.random(in: 0...1000))",
                                area: nil,
                                country: nil),
                 forecast: nil)
    }

}

extension Location.GeoData {

    static func stub(latitude: Double = 0.0,
                     longitude: Double = 0.0,
                     name: String = "Stub",
                     area: String? = nil,
                     country: String? = nil) -> Location.GeoData {

        Location.GeoData(latitude: latitude,
                         longitude: longitude,
                         name: name,
                         area: area,
                         country: country)

    }

}
