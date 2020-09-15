import Foundation

extension Date {

    func hours(in timezone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }

    func hoursAndMinutes(in timezone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }

    func dateHoursAndMinutes(in timezone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }

    func weekday(in timezone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }
    
}
