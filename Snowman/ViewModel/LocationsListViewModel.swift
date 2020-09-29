import Foundation
import SwiftUI

final class LocationsListViewModel: ObservableObject {

    // MARK: -  Properties
    
    @Published private(set) var locations = [LocationViewModel]()
    @Published private(set) var navigationBackground: Color

    // MARK: Search
    @Published private(set) var isSearching = false
    private(set) var searchResults = [LocationViewModel]()
    private(set) var searchFailed = false

    // MARK: Preferences
    let preferences: PreferencesViewModel

    // MARK: Private
    private var api: APIServiceProtocol
    private var updateTimer: Timer?
    private var locationsForecastsLastUpdated: Date?

    // MARK: - Init
    
    init(api: APIServiceProtocol, persistance: PersistenceServiceProtocol) {
        // MARK: Properties
        self.api = api
        self.preferences = PreferencesViewModel(service: persistance)
        self.locations = preferences.locations.map { LocationViewModel(model: $0) }
        self.navigationBackground = preferences.themeVM.background()
        self.updateTimer = Timer.scheduledTimer(timeInterval: 1800,
                                                target: self,
                                                selector: #selector(updateLocations),
                                                userInfo: nil,
                                                repeats: true)
        // MARK: Notifications
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateLocationsPreferences),
                                               name: .locationDetailToggled,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateNavigationBackground),
                                               name: .locationsDataUpdated,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateUnits),
                                               name: .unitsPreferenceChanged,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateNavigationBackground),
                                               name: .tintPreferenceChanged,
                                               object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self,
                                                          selector: #selector(updateLocations),
                                                          name: NSWorkspace.didWakeNotification,
                                                          object: nil)
        // MARK: Forecasts
        updateLocations()
    }

    // MARK: - Actions
    
    func add(location locationVM: LocationViewModel) {
        api.getForecast(for: locationVM.location, in: preferences.units, completion: locationVM.updateForecast)
        locations.append(locationVM)
        updateLocationsPreferences()
    }

    func search(location query: String) {
        isSearching = true
        api.searchLocations(query) { result in
            switch result {
            case .success(let locations):
                self.searchFailed = false
                self.searchResults = locations.map { LocationViewModel(model: $0) }
            case .failure(_):
                self.searchFailed = true
                self.searchResults.removeAll()
            }
            self.isSearching = false
        }
    }
    
    func move(from indexSet: IndexSet, to index: Int) {
        locations.move(fromOffsets: indexSet, toOffset: index)
        updateLocationsPreferences()
    }
    
    func remove(_ location: LocationViewModel) {
        locations.removeAll { $0 === location }
        updateLocationsPreferences()
    }
    
    @objc func updateLocations() {
        locations.forEach { locationVM in
            api.getForecast(for: locationVM.location, in: preferences.units, completion: locationVM.updateForecast)
        }
        locationsForecastsLastUpdated = Date()
    }

    @objc func updateUnits() {
        locations.forEach { locationVM in
            if locationVM.hasForecast {
                UnitsConverterService().convert(locationVM.location.forecast!,
                                                to: preferences.units,
                                                completion: locationVM.updateForecast)
            }
        }
    }

    @objc func updateNavigationBackground() {
        navigationBackground = preferences.themeVM.background(for: locations.first?.currentIcon)
    }

    // MARK: - Computed

    var lastUpdate: String {
        locationsForecastsLastUpdated?.dateHoursAndMinutes() ?? NSLocalizedString("_never_", comment: "")
    }
    
    var dataSource: String? {
        api.dataSourceName
    }

    // MARK: Title

    var forecastSummary: String {
        locations.map { $0.forecastSummary }.joined(separator: ", ")
    }

    var forecastFirstLocation: String {
        locations.first?.forecastSummary ?? ""
    }

    var statusBarTitle: String {
        var title: String

        switch preferences.statusBarAppearance {
        case .appIcon:
            title = statusBarAppIcon
        case .forecastFirst:
            title = forecastFirstLocation
        case .forecastFull:
            title = forecastSummary
        }

        return title.isEmpty ? statusBarAppIcon : title
    }

    private let statusBarAppIcon = "⛄️"

    // MARK: - Private Methods

    @objc private func updateLocationsPreferences() {
        preferences.locations = self.locations.map {
            // Don't save Location's forecast or error to persistance.
            Location(geoData: $0.location.geoData, showDetail: $0.location.showDetail)
        }
    }

}
