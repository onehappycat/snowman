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
                    LazyVStack(spacing: 0) {

                        if self.locationsList.isSearching {
                            SearchHeading("_searching_")
                        } else if self.locationsList.searchFailed {
                            SearchHeading("_error_")
                        } else if self.locationsList.searchResults.isEmpty {
                            SearchHeading("_no_results_for_ \(self.lastSearchQuery)")
                        } else {
                            VStack(spacing: 0) {
                                SearchHeading("_results_for_ \(self.lastSearchQuery)")
                                
                                Divider()

                                ForEach(self.locationsList.searchResults) { location in
                                    HStack {
                                        Spacer()
                                        Text("\(location.fullName)")
                                            .font(.title2)
                                            .foregroundColor(.accentColor)
                                            .padding()
                                        Spacer()
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.add(location) }

                                    Divider()
                                }

                                Spacer()
                            }.padding(.horizontal).padding(.bottom)
                        }

                    }.frame(width: 400, height: 300, alignment: .top)
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

extension SettingsView.AddLocationView {
    
    struct SearchHeading: View {
            
        let text: LocalizedStringKey
        
        init(_ text: LocalizedStringKey) {
            self.text = text
        }
        
        var body: some View {
            Text(text)
                .font(.title2)
                .padding(.top, 20)
                .padding(.bottom, 10)
        }
    }
    
}
