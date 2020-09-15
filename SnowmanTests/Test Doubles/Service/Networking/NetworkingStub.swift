import XCTest
@testable import Snowman

final class NetworkingStub: NetworkingServiceProtocol {

    private let result: Result<Data, SnowmanError>

    // MARK: - Init

    init(result: Data) {
        self.result = .success(result)
    }

    init(error: SnowmanError) {
        self.result = .failure(error)
    }

    // MARK: - Methods

    func get(_ url: String, completion: @escaping (Result<Data, SnowmanError>) -> Void) {
        completion(result)
    }

}
