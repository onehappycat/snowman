import Foundation

struct DarkSkyResponse: Codable {
    
    let latitude: Double
    let longitude: Double
    let timezone: String
    
    let currently: DataPoint?
    // let minutely: DataBlock?
    let hourly: DataBlock?
    let daily: DataBlock?
    
    // let alerts: Flags?
    // let flags: Flags?
    
}
