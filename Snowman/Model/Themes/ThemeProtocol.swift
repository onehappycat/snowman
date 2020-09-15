import SwiftUI

protocol ThemeProtocol {
    
    func iconAsset(for status: WeatherStatus) -> String
    func backgroundColor(for status: WeatherStatus) -> Color

}
