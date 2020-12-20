import SwiftUI

extension SettingsView {

    struct PreferencesView: View {

        // MARK: - Properties

        @EnvironmentObject private var preferences: PreferencesViewModel

        // MARK: - Body

        var body: some View {
            HStack {
                Spacer()

                VStack {
                    // MARK: Units
                    Picker(selection: $preferences.units, label: PickerLabel(text: "_units_")) {
                        ForEach(preferences.units.options) { option in
                            Text(option.label).tag(option).frame(alignment: .center)
                        }
                    }.frame(width: 220)

                    // MARK: StatusBarAppearance
                    Picker(selection: $preferences.statusBarAppearance, label: PickerLabel(text: "_status_bar_")) {
                        ForEach(preferences.statusBarAppearance.options) { option in
                            Text(option.label).tag(option).frame(alignment: .center)
                        }
                    }.frame(width: 220)
                }

                Spacer()

                VStack {
                    // MARK: Theme
                    Picker(selection: $preferences.theme, label: PickerLabel(text: "_theme_")) {
                        ForEach(preferences.theme.options) { option in
                            Text(option.label).tag(option)
                        }
                    }.frame(width: 220)

                    // MARK: BackgroundColorTint
                    Picker(selection: $preferences.backgroundColorTint, label: PickerLabel(text: "_color_tint_")) {
                        ForEach(preferences.backgroundColorTint.options) { option in
                            Text(option.label).tag(option).frame(alignment: .center)
                        }
                    }.frame(width: 220)
                }

                Spacer()
            }
        }
        
        struct PickerLabel: View {
            var text: LocalizedStringKey
            
            var body: some View {
                Text(text).frame(width: 80, alignment: .leading)
            }
        }

    }

}
