import SwiftUI

struct HourlyDataView: View {

    let hour: HourlyDataViewModel
    @EnvironmentObject var theme: ThemeViewModel

    var body: some View {
        VStack(spacing: 0) {
            Text(hour.time)

            Text(hour.precipProbability)
                .foregroundColor(.systemBlue)

            Image(theme.icon(for: hour.icon))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)

            Text(hour.temperature)
        }.frame(width: 60, height: 60, alignment: .center)
    }
    
}
