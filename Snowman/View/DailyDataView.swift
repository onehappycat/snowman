import SwiftUI

struct DailyDataView: View {
    
    let day: DailyDataViewModel
    @EnvironmentObject var theme: ThemeViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Text(day.name)
                .frame(width: 130, alignment: .leading)
            
            Image(theme.icon(for: day.icon))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 25, alignment: .leading)
            
            Text(day.precipProbability)
                .foregroundColor(.systemBlue)
                .frame(width: 40, alignment: .trailing)
                .padding(.trailing, 40)
            
            Text(day.temperatureHigh)
                .frame(width: 40, alignment: .trailing)
            
            Text(day.temperatureLow)
                .opacity(0.7)
                .frame(width: 40, alignment: .trailing)
        }
    }
    
}
