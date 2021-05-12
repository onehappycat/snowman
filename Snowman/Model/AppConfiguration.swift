import Foundation

struct AppConfiguration: Decodable {
    private enum CodingKeys: String, CodingKey {
        case apiKey
    }
    
    let apiKey: String
}
