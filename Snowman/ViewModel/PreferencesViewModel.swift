import Foundation

final class PreferencesViewModel: ObservableObject {

    // MARK: - Properties

    let themeVM: ThemeViewModel
    @Published private var preferences: Preferences
    private var persistance: PersistenceServiceProtocol

    // MARK: - Init

    init(service: PersistenceServiceProtocol) {
        self.persistance = service
        let preferences = persistance.load()
        self.preferences = preferences
        self.themeVM = ThemeViewModel(theme: preferences.theme, tint: preferences.backgroundColorTint)
    }

    // MARK: - Internal Properties

    var locations: [Location] {
        get {
            preferences.locations
        }
        set {
            preferences.locations = newValue
            savePreferences()
            NotificationCenter.default.post(name: .locationsDataUpdated, object: nil)
        }
    }

    var units: Preferences.Units {
        get {
            preferences.units
        }
        set {
            preferences.units = newValue
            savePreferences()
            NotificationCenter.default.post(name: .unitsPreferenceChanged, object: nil)
        }

    }

    var statusBarAppearance: Preferences.StatusBarAppearance {
        get {
            preferences.statusBarAppearance
        }
        set {
            preferences.statusBarAppearance = newValue
            savePreferences()
            NotificationCenter.default.post(name: .locationsDataUpdated, object: nil)
        }
    }

    var theme: Preferences.Theme {
        get {
            preferences.theme
        }
        set {
            preferences.theme = newValue
            savePreferences()
            themeVM.update(theme: newValue)
        }
    }

    var backgroundColorTint: Preferences.BackgroundColorTint {
        get {
            preferences.backgroundColorTint
        }
        set {
            preferences.backgroundColorTint = newValue
            savePreferences()
            themeVM.update(tint: newValue)
            NotificationCenter.default.post(name: .tintPreferenceChanged, object: nil)
        }
    }

    var appVersion: String {
        Bundle.main.version ?? ""
    }

    var appName: String {
        Bundle.main.displayName ?? ""
    }

    // MARK: - Private Methods

    private func savePreferences() {
        persistance.save(preferences)
    }

    // MARK: - PreferencesViewRepresentable Alternative

    func options<T>(for preference: T) -> T.AllCases where T: CaseIterable {
        T.allCases
    }

    func label<T>(for preference: T) -> String where T: RawRepresentable, T.RawValue == String {
        NSLocalizedString("\(T.self).\(preference.rawValue)", comment: "")
    }

}
