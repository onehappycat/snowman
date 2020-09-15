import XCTest
@testable import Snowman

final class SnowmanTests: XCTestCase {
    
    static func load(fixture file: String) -> Data {
        let bundle = Bundle(for: SnowmanTests.self)
        let url = bundle.url(forResource: file, withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
}
