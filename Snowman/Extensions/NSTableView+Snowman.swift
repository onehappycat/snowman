import AppKit

extension NSTableView {

    // Customizes List View appearance in SwiftUI

    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        enclosingScrollView?.drawsBackground = false
        enclosingScrollView?.backgroundColor = .clear
        enclosingScrollView?.autohidesScrollers = true
    }

}
