import XCTest
@testable import Snowman

final class NetworkingDummy: NetworkingServiceProtocol {

    func get(_ url: String, completion: @escaping (Result<Data, SnowmanError>) -> Void) {
        // Does nothing
    }

}
