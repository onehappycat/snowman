import Foundation

final class DailyDataViewModel: Identifiable, WeatherDataPresenter {
    
    private let model: WeatherForecast.DailyData

    // MARK: - Init

    init(day model: WeatherForecast.DailyData) {
        self.model = model
    }

    // MARK: - Properties

    var name: String {
        model.date.weekday()
    }
    
    var temperatureHigh: String {
        present(temperature: model.temperatureHigh)
    }
    
    var temperatureLow: String {
        present(temperature: model.temperatureLow)
    }
    
    var icon: WeatherStatus {
        model.icon
    }
    
    var precipProbability: String {
        let probability = model.precipProbability
        return probability >= 0.01 ? present(precipitation: probability) : ""
    }
    
}
