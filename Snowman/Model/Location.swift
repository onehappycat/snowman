import Foundation

struct Location: Codable {

    let geoData: GeoData
    var showDetail = true

    var forecast: WeatherForecast?
    var error: SnowmanError?

}

extension Location {

    struct GeoData: Codable {

        let latitude: Double
        let longitude: Double
        let name: String
        let area: String?
        let country: String?

    }
}

extension Location: Equatable {

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.geoData == rhs.geoData
    }

}

extension Location.GeoData: Equatable {

    static func == (lhs: Location.GeoData, rhs: Location.GeoData) -> Bool {
        lhs.latitude == rhs.latitude && rhs.longitude == rhs.longitude
    }

}
