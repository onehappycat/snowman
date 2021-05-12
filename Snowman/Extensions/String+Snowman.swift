import Foundation

extension String {

    func camelToSnakeCase() -> String {
        self.replacingOccurrences(of: "([a-z])([A-Z]|[0-9])", with: "$1_$2", options: .regularExpression)
            .replacingOccurrences(of: "([0-9])([A-Z])", with: "$1_$2", options: .regularExpression)
            .replacingOccurrences(of: "([A-Z]+)([A-Z][a-z]|[0-9])", with: "$1_$2", options: .regularExpression)
            .lowercased()
    }

    func snakeToCamelCase() -> String {
        self.split(separator: "_")
            .map { $0.capitalized }
            .joined(separator: "")
    }

    func dropTrailingSlashIfPresent() -> String {
        (self.last == "/") ? String(self.dropLast()) : self
    }

}
