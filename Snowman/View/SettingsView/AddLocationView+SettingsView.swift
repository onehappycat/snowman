import SwiftUI

extension SettingsView {

    struct AddLocationView: View {

        // MARK: - Properties

        @EnvironmentObject private var locationsList: LocationsListViewModel

        // MARK: Search
        @State private var presentingPopover = false
        @State private var searchFieldText = ""
        @State private var lastSearchQuery = ""

        // MARK: - Body

        var body: some View {
            HStack {
                Text("_add_location_")

                TextField("_search_by_city_name_or_zip_code_", text: $searchFieldText, onCommit: {
                    self.searchButtonPressed()
                }).frame(width: 280.0)

                Button(action: {
                    self.searchButtonPressed()
                }) {
                    Text("_search_").frame(width: 60)
                }
            }
            // MARK: Results Popover View
            .popover(isPresented: $presentingPopover, arrowEdge: .bottom) {
                ScrollView {
                    // TODO in SwiftUI 2: LazyVStack
                    VStack(spacing: 0) {

                        if self.locationsList.isSearching {
                            Text("_searching_")
                        } else if self.locationsList.searchFailed {
                            Text("_error_")
                        } else if self.locationsList.searchResults.isEmpty {
                            Text("_no_results_for_ \(self.lastSearchQuery)")
                                .font(.callout)
                        } else {
                            VStack(spacing: 0) {
                                Text("_results_for_ \(self.lastSearchQuery)")
                                    .font(.subheadline)
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)

                                Divider()

                                ForEach(self.locationsList.searchResults) { location in
                                    HStack {
                                        Spacer()
                                        Text("\(location.fullName)")
                                            .font(.callout)
                                            .foregroundColor(.accentColor)
                                            .padding()
                                        Spacer()
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.add(location) }

                                    Divider()
                                }

                                Spacer()
                            }.padding(.leading).padding(.trailing).padding(.bottom)
                        }

                    }.frame(width: 400, height: 300)
                }
            }
        }

        // MARK: - Private Methods

        private func clearSearchField() {
            searchFieldText = ""
        }

        private func searchButtonPressed() {
            if searchFieldText.count > 0 {
                locationsList.search(location: searchFieldText)
                presentingPopover = true
                lastSearchQuery = searchFieldText
                clearSearchField()
            }
        }

        private func add(_ location: LocationViewModel) {
            locationsList.add(location: location)
            presentingPopover = false
            clearSearchField()
        }

    }

}
