import Foundation

extension Bundle {

    var version: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var build: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }

    var displayName: String? {
        infoDictionary?["CFBundleDisplayName"] as? String
    }

}
