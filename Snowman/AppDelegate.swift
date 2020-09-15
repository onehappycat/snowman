import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Private Properties

    private var statusBarItem: NSStatusItem!
    private var popover: NSPopover!
    private var locationsListVM: LocationsListViewModel!

    // MARK: - Status Bar Item Initialization

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // API Service
        let apiService = OpenWeatherAPI(key: "OW_API_KEY", networking: NetworkingService())

        // Persistance Service
        let persistanceService = PersistenceService()

        // View Model of the Popover's Root View
        locationsListVM = LocationsListViewModel(api: apiService, persistance: persistanceService)

        constructStatusBarItem()
    }
    
    // MARK: - Private Methods
    
    private func constructStatusBarItem() {
        let locationsListView = LocationsListView(viewModel: locationsListVM)
        popover = NSPopover()
        popover.contentViewController = NSHostingController(rootView: locationsListView)
        popover.contentSize = NSSize(width: 460, height: 100)
        popover.behavior = .transient
        popover.animates = false
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = statusBarItem.button {
            button.title = locationsListVM.statusBarTitle
            button.action = #selector(togglePopover(_:))
            button.target = self
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateStatusBarButtonTitle),
                                               name: .locationsDataUpdated,
                                               object: nil)
    }

    // MARK: Status Bar Button Title

    @objc private func updateStatusBarButtonTitle() {
        if let button = statusBarItem.button {
            button.title = locationsListVM.statusBarTitle
        }
    }

    // MARK: Popover Actions
    
    @objc private func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    private func showPopover(sender: Any?) {
        if let button = statusBarItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    private func closePopover(sender: Any?) {
        popover.performClose(sender)
    }

}
