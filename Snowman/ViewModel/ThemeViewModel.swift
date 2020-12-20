import SwiftUI

final class ThemeViewModel: ObservableObject {

    // MARK: - Properties

    @Published private var theme: ThemeProtocol = DefaultTheme()
    @Published private var tintOn = true

    // MARK: - Init

    init(theme: Preferences.Theme, tint: Preferences.BackgroundColorTint) {
        update(theme: theme)
        update(tint: tint)
    }

    // MARK: - Methods

    func icon(for weatherStatus: WeatherStatus) -> String {
        theme.iconAsset(for: weatherStatus)
    }

    func background(for weatherStatus: WeatherStatus? = nil) -> Color {
        guard tintOn, let status = weatherStatus else {
            return Color.underPageBackgroundColor.opacity(0.6)
        }

        return theme.backgroundColor(for: status)
    }

    func update(theme: Preferences.Theme) {
        switch theme {
        case .defaultTheme:
            self.theme = DefaultTheme()
        case .monochrome:
            self.theme = MonochromeTheme()
        case .sfSymbols:
            self.theme = SFSymbolsTheme()
        }
    }

    func update(tint: Preferences.BackgroundColorTint) {
        self.tintOn = tint == .on
    }
    
    var isUsingSFSymbols: Bool {
        theme.isUsingSFSymbols
    }

}
