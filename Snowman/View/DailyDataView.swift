import SwiftUI

struct DailyDataView: View {
    
    let day: DailyDataViewModel
    @EnvironmentObject var theme: ThemeViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Text(day.name)
                .frame(width: 130, alignment: .leading)
            
            WeatherIconView(icon: theme.icon(for: day.icon), isUsingSFSymbols: theme.isUsingSFSymbols)
            
            Text(day.precipProbability)
                .foregroundColor(.systemBlue)
                .frame(width: 40, alignment: .trailing)
                .padding(.trailing, 40)
            
            Text(day.temperatureHigh)
                .frame(width: 40, alignment: .trailing)
            
            Text(day.temperatureLow)
                .opacity(0.7)
                .frame(width: 40, alignment: .trailing)
        }.frame(width: 350, height: 20)
    }
    
}

extension DailyDataView {
    
    struct WeatherIconView: View {
        
        var icon: String
        var isUsingSFSymbols: Bool
        
        var body: some View {
            if isUsingSFSymbols {
                Image(systemName: icon)
                    .resizable()
                    .renderingMode(.original)
                    .font(Font.system(.largeTitle).bold())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 20, alignment: .leading)
            } else {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 25, alignment: .leading)
            }
        }
    }
    
}
