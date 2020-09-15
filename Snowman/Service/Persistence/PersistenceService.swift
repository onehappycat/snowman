import Foundation

final class PersistenceService: PersistenceServiceProtocol {

    private let defaults = UserDefaults.standard
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private let key = "snowmanPreferences"

    // MARK: - PersistenceServiceProtocol

    func save(_ preferences: Preferences) {
        if let data = try? encoder.encode(preferences) {
            defaults.set(data, forKey: key)
        }
    }

    func load() -> Preferences {
        if let data = defaults.object(forKey: key) as? Data,
            let preferences = try? decoder.decode(Preferences.self, from: data) {
            return preferences
        } else {
            return Preferences.defaultValues
        }
    }

}
