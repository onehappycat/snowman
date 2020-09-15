import Foundation

protocol GeocoderServiceProtocol {

    func locations(for query: String, completion: @escaping (Result<[Location], SnowmanError>) -> Void)

}
