import Foundation

enum SnowmanError: Int, Error, Codable {

    case unknown = 0
    case apiDataDecoding = 1
    case apiDataParsing = 2
    case networkInvalidURL = 3
    case networkRequestFailed = 4
    case responseUnknownError = 5
    case responseUnauthorized = 6
    case responseBadRequest = 7
    case locationInvalidDataState = 8


}
