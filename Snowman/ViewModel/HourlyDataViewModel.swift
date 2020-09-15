import Foundation

final class HourlyDataViewModel: Identifiable, WeatherDataPresenter {
    
    private let model: WeatherForecast.HourlyData

    // MARK: - Init

    init(hour model: WeatherForecast.HourlyData) {
        self.model = model
    }

    // MARK: - Properties

    var time: String {
        let hours = model.date.hours(in: model.timezone)
        let now = Date().hours(in: model.timezone)
        return hours == now ? NSLocalizedString("_now_", comment: "") : hours
    }
    
    var temperature: String {
        present(temperature: model.temperature)
    }
    
    var apparentTemperature: String {
        present(temperature: model.apparentTemperature)
    }
    
    var icon: WeatherStatus {
        model.icon
    }
    
    var precipProbability: String {
        let probability = model.precipProbability
        return probability >= 0.01 ? present(precipitation: probability) : ""
    }
    
}
