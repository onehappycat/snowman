import SwiftUI

struct SettingsView: View {

    // MARK: - Properties
    
    @EnvironmentObject private var locationsList: LocationsListViewModel
    @EnvironmentObject private var preferences: PreferencesViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            AddLocationView()
            CustomDivider()

            LocationsListView()
            CustomDivider()

            PreferencesView()
            CustomDivider()

            ControlsView()
        }.padding(20)
    }

}

// MARK: - Divider

extension SettingsView {

    struct CustomDivider: View {
        var body: some View {
            Divider().opacity(0.5).padding(.top, 10).padding(.bottom, 10)
        }
    }

}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let apiService = OpenWeatherAPI(key: "OW_API_KEY", networking: NetworkingService())
        let persistanceService = PersistenceService()
        let locationsListVM = LocationsListViewModel(api: apiService, persistance: persistanceService)
        return SettingsView().environmentObject(locationsListVM).environmentObject(locationsListVM.preferences)
    }
}
