import Foundation
import SwiftUI

final class LocationViewModel: ObservableObject, Identifiable {

    // MARK: -  Properties
    
    @Published private(set) var location: Location

    // MARK: - Init

    init(model location: Location) {
        self.location = location
    }

    // MARK: - Computed

    var name: String {
        location.geoData.name
    }

    var fullName: String {
        name + country
    }

    /**
     Returns area name and/or country name separated by commas,
     with a leading comma, or empty string if not available.
     */
    var country: String {
        var names = [""]
        names.append(location.geoData.area ?? "")
        names.append(location.geoData.country ?? "")
        /*
         Filter names to avoid repetition (e.g. if area == country and/or name == area).
         Empty string in names ensures a leading comma, unless it's the only element, and
         filters out potential empty strings from area/country to avoid surplus commas.
         */
        var seen: Set = [name]
        names = names.filter { seen.insert($0).inserted }

        return names.joined(separator: ", ")
    }
    
    var hasForecast: Bool {
        location.forecast != nil
    }
    
    var currentForecast: HourlyDataViewModel {
        .init(hour: location.forecast!.currently)
    }
    
    var dailyForecast: [DailyDataViewModel] {
        location.forecast!.daily.prefix(7).map { .init(day: $0) }
    }
    
    var hourlyForecast: [HourlyDataViewModel] {
        location.forecast!.hourly.prefix(6).map { .init(hour: $0) }
    }

    var currentIcon: WeatherStatus? {
        location.forecast?.currently.icon
    }
    
    func isCurrently(_ description: [WeatherStatus.Description?]) -> Bool {
        description.contains(currentIcon?.description)
    }
    
    func isAboutToBe(_ description: [WeatherStatus.Description]) -> Bool {
        let forecast = hourlyForecast.prefix(2).map { $0.icon.description }
        return !Set(description).isDisjoint(with: forecast)
    }
    
    var forecastSummary: String {
        guard hasForecast else {
            return String(format: NSLocalizedString("_error_with_code_status_bar_ %@", comment: ""), errorCode)
        }

        var items = [
            "\(name):",
            "\(currentForecast.temperature)",
        ]
        
        let raining: [WeatherStatus.Description] = [.rain, .thunderstorm, .sleet]
        let snowing: [WeatherStatus.Description] = [.snow]
        
        // Current Weather Takes Precedence Over Upcoming Forecast
        if isCurrently(raining) {
            items.append(rainLabel)
        } else if isCurrently(snowing) {
            items.append(snowLabel)
        } else if isAboutToBe(raining) {
            items.append(rainLabel)
        } else if isAboutToBe(snowing) {
            items.append(snowLabel)
        }

        return items.joined(separator: " ")
    }

    var showDetail: Bool {
        get {
            location.showDetail
        }
        set {
            location.showDetail = newValue
            NotificationCenter.default.post(name: .locationDetailToggled, object: nil)
        }
    }

    var errorCode: String {
        guard let error = location.error else {
            return hasForecast ? "" : "\(SnowmanError.locationInvalidDataState.rawValue)"
        }

        return hasForecast ? "\(SnowmanError.locationInvalidDataState.rawValue)" : "\(error.rawValue)"
    }

    func forecastBackground(for colorScheme: ColorScheme) -> Color {
        Color.textBackgroundColor.opacity(colorScheme == .light ? 0.45 : 0.8)
    }

    // MARK: - Actions

    func updateForecast(_ result: Result<WeatherForecast, SnowmanError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let forecast):
                self.location.forecast = forecast
                self.location.error = nil
            case .failure(let error):
                self.location.forecast = nil
                self.location.error = error
            }
            NotificationCenter.default.post(name: .locationsDataUpdated, object: nil)
        }
    }

    func updateForecast(_ forecast: WeatherForecast) {
        DispatchQueue.main.async {
            self.location.forecast = forecast
            NotificationCenter.default.post(name: .locationsDataUpdated, object: nil)
        }
    }
    
    // MARK: - Private
    
    private var rainLabel: String {
        "☂"
    }
    
    private var snowLabel: String {
        "❄︎"
    }
    
}
