import SwiftUI

extension SettingsView {

    struct AboutView: View {

        // MARK: - Properties

        @Environment(\.presentationMode) var presentationMode
        @EnvironmentObject private var preferences: PreferencesViewModel
        @EnvironmentObject private var locations: LocationsListViewModel

        // MARK: - Body

        var body: some View {
            VStack {
                // App Name
                Text(preferences.appName)
                    .font(.headline)

                // App Version
                Text("_version_ \(preferences.appVersion)")
                    .font(.footnote)

                // Last Update
                Text("_last_update_ \(locations.lastUpdate)")
                    .font(.footnote)
                    .padding(.vertical)

                // Dissmiss Button
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("_ok_").frame(width: 60)
                }
            }
            .frame(width: 300, height: 200)
            .padding()
        }

    }

}
