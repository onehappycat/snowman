import Foundation

protocol PersistenceServiceProtocol {

    func save(_ preferences: Preferences)
    func load() -> Preferences

}
