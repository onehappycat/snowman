import SwiftUI

extension SettingsView {

    struct LocationsListView: View {

        // MARK: - Properties

        @EnvironmentObject private var locationsList: LocationsListViewModel

        // MARK: - Body

        var body: some View {
            VStack {
                // MARK: - Locations List
                List {
                    ForEach(locationsList.locations) { location in
                        VStack(spacing: 0) {
                            HStack {
                                Text("\(location.fullName)")
                                    .foregroundColor(.labelColor)

                                Spacer()

                                Text("_remove_")
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .padding(8)
                                    .background(Color.systemRed)
                                    .cornerRadius(6)
                                    .onTapGesture { self.locationsList.remove(location) }
                            }
                            .frame(height: 50)
                            .background(Color.clear)
                            .cornerRadius(6)

                            Divider().padding(.vertical, 5)
                        }
                    }
                    .onMove { (indexSet, index) in
                        self.locationsList.move(from: indexSet, to: index)
                    }
                    // Negative padding is a workaround, .listRowInsets(EdgeInsets()) does not currently work on macOS.
                    .padding(.vertical, -4)//.padding(.horizontal, -8)
                }.cornerRadius(10)
            }
        }

    }

}
