import Foundation

protocol WeatherDataPresenter {

    func present(temperature: Double) -> String
    func present(precipitation: Double) -> String

}

extension WeatherDataPresenter {

    func present(temperature: Double) -> String {
        "\(Int(round(temperature)))°"
    }
    
    func present(precipitation probability: Double) -> String {
        "\(Int(round(probability * 100)))%"
    }

}
