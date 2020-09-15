import Foundation

extension DarkSkyResponse {

    struct DataBlock: Codable {

        let data: [DataPoint]
        let icon: String?
        let summary: String?

    }

}
