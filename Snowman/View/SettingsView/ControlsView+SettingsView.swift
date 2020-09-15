import SwiftUI

extension SettingsView {

    struct ControlsView: View {

        // MARK: - Properties

        @EnvironmentObject private var preferences: PreferencesViewModel
        @EnvironmentObject private var locations: LocationsListViewModel
        @State private var showingAboutSheet = false

        // MARK: - Body

        var body: some View {
            HStack {
                // MARK: About Button
                Button(action: {
                    self.showingAboutSheet = true
                }) {
                    Text("_about_").frame(width: 60)
                }.sheet(isPresented: $showingAboutSheet) {
                    AboutView().environmentObject(self.preferences).environmentObject(self.locations)
                }

                // MARK: Quit Button
                Button(action: {
                    NSApplication.shared.terminate(self)
                }) {
                    Text("_quit_").frame(width: 60)
                }
            }
        }

    }

}
