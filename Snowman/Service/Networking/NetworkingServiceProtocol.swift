import Foundation

protocol NetworkingServiceProtocol {

    func get(_ url: String, completion: @escaping (Result<Data, SnowmanError>) -> Void)

}
