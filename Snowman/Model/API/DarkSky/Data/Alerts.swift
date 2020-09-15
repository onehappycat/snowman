import Foundation

extension DarkSkyResponse {

    struct Alerts: Codable {

        let description: String
        let expires: Int
        let regions: [String]
        let severity: String
        let time: Int
        let title: String
        let uri: String

    }

}
