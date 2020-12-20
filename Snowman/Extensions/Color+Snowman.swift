import SwiftUI

extension Color {

    // MARK: - Custom Background Colors

    static let skyClear = Color(NSColor(calibratedRed: 122/255.0, green: 182/255.0, blue: 250/255.0, alpha: 1.0))
    static let skyClearNight = Color(NSColor(calibratedRed: 45/255.0, green: 45/255.0, blue: 105/255.0, alpha: 1.0))

    static let skyPartlyCloudy = Color(NSColor(calibratedRed: 157/255.0, green: 192/255.0, blue: 246/255.0, alpha: 1.0))
    static let skyPartlyCloudyNight = Color(NSColor(calibratedRed: 40/255.0, green: 40/255.0, blue: 85/255.0, alpha: 0.9))

    static let skyCloudy = Color(NSColor(calibratedRed: 160/255.0, green: 160/255.0, blue: 160/255.0, alpha: 0.6))
    static let skyCloudyNight = Color(NSColor(calibratedRed: 30/255.0, green: 30/255.0, blue: 60/255.0, alpha: 0.8))

    static let skyRain = Color(NSColor(calibratedRed: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 0.8))

    // MARK: - Standard Colors (NSColor)

    // MARK: Adaptable System Colors
    static let systemBlue = Color(NSColor.systemBlue)
    static let systemBrown = Color(NSColor.systemBrown)
    static let systemGray = Color(NSColor.systemGray)
    static let systemGreen = Color(NSColor.systemGreen)
    static let systemIndigo = Color(NSColor.systemIndigo)
    static let systemOrange = Color(NSColor.systemOrange)
    static let systemPink = Color(NSColor.systemPink)
    static let systemPurple = Color(NSColor.systemPurple)
    static let systemRed = Color(NSColor.systemRed)
    static let systemTeal = Color(NSColor.systemTeal)
    static let systemYellow = Color(NSColor.systemYellow)

    // MARK: - UI Element Colors (NSColor)

    // MARK: Label Colors
    static let labelColor = Color(NSColor.labelColor)
    static let secondaryLabelColor = Color(NSColor.secondaryLabelColor)
    static let tertiaryLabelColor = Color(NSColor.tertiaryLabelColor)
    static let quaternaryLabelColor = Color(NSColor.quaternaryLabelColor)

    // MARK: Text Colors
    static let textColor = Color(NSColor.textColor)
    static let placeholderTextColor = Color(NSColor.placeholderTextColor)
    static let selectedTextColor = Color(NSColor.selectedTextColor)
    static let textBackgroundColor = Color(NSColor.textBackgroundColor)
    static let selectedTextBackgroundColor = Color(NSColor.selectedTextBackgroundColor)
    static let keyboardFocusIndicatorColor = Color(NSColor.keyboardFocusIndicatorColor)
    static let unemphasizedSelectedTextColor = Color(NSColor.unemphasizedSelectedTextColor)
    static let unemphasizedSelectedTextBackgroundColor = Color(NSColor.unemphasizedSelectedTextBackgroundColor)

    // MARK: Content Colors
    static let linkColor = Color(NSColor.linkColor)
    static let separatorColor = Color(NSColor.separatorColor)
    static let selectedContentBackgroundColor = Color(NSColor.selectedContentBackgroundColor)
    static let unemphasizedSelectedContentBackgroundColor = Color(NSColor.unemphasizedSelectedContentBackgroundColor)

    // MARK: Menu Colors
    static let selectedMenuItemTextColor = Color(NSColor.selectedMenuItemTextColor)

    // MARK: Table Colors
    static let gridColor = Color(NSColor.gridColor)
    static let alternatingContentBackgroundColors = NSColor.alternatingContentBackgroundColors.map { Color($0) }

    // MARK: Control Colors
    static let controlAccentColor = Color(NSColor.controlAccentColor)
    static let controlColor = Color(NSColor.controlColor)
    static let controlBackgroundColor = Color(NSColor.controlBackgroundColor)
    static let controlTextColor = Color(NSColor.controlTextColor)
    static let disabledControlTextColor = Color(NSColor.disabledControlTextColor)
    //currentControlTint
    static let selectedControlColor = Color(NSColor.selectedControlColor)
    static let selectedControlTextColor = Color(NSColor.selectedControlTextColor)
    static let alternateSelectedControlTextColor = Color(NSColor.alternateSelectedControlTextColor)
    static let scrubberTexturedBackground = Color(NSColor.scrubberTexturedBackground)

    // MARK: Window Colors
    static let windowBackgroundColor = Color(NSColor.windowBackgroundColor)
    static let windowFrameTextColor = Color(NSColor.windowFrameTextColor)
    static let underPageBackgroundColor = Color(NSColor.underPageBackgroundColor)

    // MARK: Highlights and Shadows
    static let findHighlightColor = Color(NSColor.findHighlightColor)
    static let highlightColor = Color(NSColor.highlightColor)
    static let shadowColor = Color(NSColor.shadowColor)

}
