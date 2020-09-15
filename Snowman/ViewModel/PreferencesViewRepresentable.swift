import Foundation

/**
 Allows for more readable SwiftUI code in PreferencesView.

 Example of use:
 ~~~
 ForEach(preferences.units.options) { option in
     Text(option.label)
 }
 ~~~

 instead of

 ~~~
 ForEach(preferences.options(for: preferences.units), id: \.self) { option in
     Text(preferences.label(for: option))
 }
 ~~~
 */

protocol PreferencesViewRepresentable: CaseIterable, RawRepresentable, Identifiable {

    var label: String { get }
    var options: AllCases { get }
    var id: ID { get }

}

extension PreferencesViewRepresentable where Self.RawValue == String {

    var label: String {
        NSLocalizedString(id, comment: "")
    }

    var options: AllCases {
        Self.allCases
    }

    var id: String {
        "_\(type(of: self))_\(rawValue)_".camelToSnakeCase()
    }

}
