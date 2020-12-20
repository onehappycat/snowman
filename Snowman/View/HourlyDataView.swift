import SwiftUI

struct HourlyDataView: View {

    let hour: HourlyDataViewModel
    @EnvironmentObject var theme: ThemeViewModel

    var body: some View {
        VStack(spacing: 0) {
            Text(hour.time)

            Text(hour.precipProbability)
                .foregroundColor(.systemBlue)

            WeatherIconView(icon: theme.icon(for: hour.icon), isUsingSFSymbols: theme.isUsingSFSymbols)

            Text(hour.temperature)
        }.frame(width: 60, height: 60, alignment: .center)
    }
    
}

extension HourlyDataView {
    
    struct WeatherIconView: View {
        
        var icon: String
        var isUsingSFSymbols: Bool
        
        var body: some View {
            if isUsingSFSymbols {
                Image(systemName: icon)
                    .renderingMode(.original)
                    .font(Font.system(.largeTitle).bold())
                    .frame(height: 30)
            } else {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            }
        }
    }
    
}
