import SwiftUI

extension SettingsView {

    struct PreferencesView: View {

        // MARK: - Properties

        @EnvironmentObject private var preferences: PreferencesViewModel

        // MARK: - Body

        var body: some View {
            HStack {
                Spacer()

                VStack(alignment: .trailing) {
                    // MARK: Units
                    Picker(selection: $preferences.units, label: Text("_units_")) {
                        ForEach(preferences.units.options) { option in
                            Text(option.label).tag(option).frame(width: 100)
                        }
                    }.fixedSize()

                    // MARK: StatusBarAppearance
                    Picker(selection: $preferences.statusBarAppearance, label: Text("_status_bar_")) {
                        ForEach(preferences.statusBarAppearance.options) { option in
                            Text(option.label).tag(option).frame(width: 100)
                        }
                    }.fixedSize()
                }

                Spacer()

                VStack(alignment: .trailing) {
                    // MARK: Theme
                    Picker(selection: $preferences.theme, label: Text("_theme_")) {
                        ForEach(preferences.theme.options) { option in
                            Text(option.label).tag(option).frame(width: 100)
                        }
                    }.fixedSize()

                    // MARK: BackgroundColorTint
                    Picker(selection: $preferences.backgroundColorTint, label: Text("_color_tint_")) {
                        ForEach(preferences.backgroundColorTint.options) { option in
                            Text(option.label).tag(option).frame(width: 100)
                        }
                    }.fixedSize()
                }

                Spacer()
            }
        }

    }

}
