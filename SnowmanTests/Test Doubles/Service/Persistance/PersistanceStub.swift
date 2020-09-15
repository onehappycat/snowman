import XCTest
@testable import Snowman

final class PersistanceStub: PersistenceServiceProtocol {

    private var preferences: Preferences?

    func save(_ preferences: Preferences) {
        self.preferences = preferences
    }

    func load() -> Preferences {
        preferences ?? Preferences.defaultValues
    }
    
}
