import SwiftUI

struct LocationsListView: View {

    // MARK: - Properties

    @ObservedObject var locationsList: LocationsListViewModel
    @ObservedObject var preferences: PreferencesViewModel
    @ObservedObject var theme: ThemeViewModel
    private var settingsWindow: NSWindow

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Navigation
            HStack {
                Spacer()
                Button(action: {
                    self.openSettingsWindow()
                }) {
                    Text("⚙")
                        .foregroundColor(.labelColor)
                        .font(.system(size: 30))
                        .padding(.trailing, 10)
                }.buttonStyle(BorderlessButtonStyle())
            }
            .background(locationsList.navigationBackground)
            .padding(.horizontal, 0)

            // MARK: Locations
            ForEach(locationsList.locations) { location in
                LocationView(location: location)
                    .environmentObject(self.theme)
                    .onTapGesture { location.showDetail.toggle() }
                    .padding(.horizontal, 0)
            }

            if locationsList.locations.isEmpty {
                HStack {
                    Spacer()
                    Text("_empty_locations_list")
                        .padding()
                    Spacer()
                }.background(locationsList.navigationBackground)
            }
        }
    }

    // MARK: - Init

    init(viewModel: LocationsListViewModel) {
        // MARK: View Models
        locationsList = viewModel
        preferences = viewModel.preferences
        theme = viewModel.preferences.themeVM

        // MARK: Settings Window
        settingsWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 580, height: 480),
                                  styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                                  backing: .buffered, defer: false)
        let settingsView = SettingsView().environmentObject(locationsList).environmentObject(preferences)
        settingsWindow.contentView = NSHostingView(rootView: settingsView)
        settingsWindow.isReleasedWhenClosed = false
        settingsWindow.center()
    }

    // MARK: - Private

    private func openSettingsWindow() {
        // Without .activate, SettingsWindow sometimes opens in the background
        NSApplication.shared.activate(ignoringOtherApps: true)
        settingsWindow.makeKeyAndOrderFront(nil)
    }

}

// MARK: - Preview

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        let apiService = OpenWeatherAPI(key: "OW_API_KEY", networking: NetworkingService())
        let persistanceService = PersistenceService()
        let locationsListVM = LocationsListViewModel(api: apiService, persistance: persistanceService)
        return LocationsListView(viewModel: locationsListVM)
    }
}
