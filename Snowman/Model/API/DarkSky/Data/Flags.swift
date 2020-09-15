import Foundation

extension DarkSkyResponse {

    struct Flags: Codable {

        let darkskyUnavailable: Bool?
        let meteoalarmLicense: String?
        let nearestStation: Double
        let sources: [Int: String]
        let units: String

    }

}
