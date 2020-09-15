import SwiftUI

struct CurrentDataView: View {
    
    let current: HourlyDataViewModel
    @EnvironmentObject var theme: ThemeViewModel
    
    var body: some View {
        HStack {
            Image(theme.icon(for: current.icon))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            
            Text(current.temperature)
                .font(.largeTitle)
                .fontWeight(.thin)
        }
    }

}
