import SwiftUI

struct LocationView: View {
    
    @ObservedObject var location: LocationViewModel
    @EnvironmentObject var theme: ThemeViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            if location.hasForecast {
                VStack {
                    HStack {
                        Text(location.name)
                        Spacer()
                        CurrentDataView(current: location.currentForecast)
                    }.padding(.horizontal, 20).padding(.vertical, 15)

                    if location.showDetail {
                        HStack {
                            ForEach(location.hourlyForecast) { hour in
                                HourlyDataView(hour: hour)
                            }
                        }.padding(.bottom, 15)

                        VStack {
                            ForEach(location.dailyForecast) { day in
                                DailyDataView(day: day)
                            }
                        }.padding(.bottom, 15)
                    }
                }
                .background(location.forecastBackground(for: colorScheme))
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            } else {
                HStack {
                    Spacer()
                    Text("_error_with_code_ \(location.errorCode)")
                        .padding(.vertical)
                    Spacer()
                }
            }
        }
        .background(self.theme.background(for: location.currentIcon))
    }
    
}

// MARK: - Preview

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(geoData: .init(latitude: 51.51, longitude: -0.1, name: "London", area: nil, country: nil))
        return LocationView(location: LocationViewModel(model: location))
    }
}
