import SwiftUI

struct CurrentDataView: View {
    
    let current: HourlyDataViewModel
    @EnvironmentObject var theme: ThemeViewModel
    
    var body: some View {
        HStack {
            WeatherIconView(icon: theme.icon(for: current.icon), isUsingSFSymbols: theme.isUsingSFSymbols)
            
            Text(current.temperature)
                .font(.system(size: 32, weight: .thin))
        }
    }

}

extension CurrentDataView {
    
    struct WeatherIconView: View {
        
        var icon: String
        var isUsingSFSymbols: Bool
        
        var body: some View {
            Group {
                if isUsingSFSymbols {
                    Image(systemName: icon)
                        .renderingMode(.original)
                        .font(Font.system(.largeTitle).bold())
                } else {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(height: 40)
        }
    }
    
}
