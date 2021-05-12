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
        // AppConfiguration
        let configuration = try! getAppConfiguration()
        
        // API Service
        let apiService = OpenWeatherAPI(key: configuration.apiKey)

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
    
    @objc private func togglePopover(_ sender: NSButton) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    private func showPopover(_ button: NSButton) {
        // A helper positioning view that makes it possible to hide the NSPopover's arrow
        let positioningView = NSView(frame: button.bounds)
        positioningView.identifier = positioningViewIdentifier()
        button.addSubview(positioningView)
        
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.maxY)
        button.bounds = button.bounds.offsetBy(dx: 0, dy: button.bounds.height)

        if let popoverWindow = popover.contentViewController?.view.window {
            popoverWindow.setFrame(popoverWindow.frame.offsetBy(dx: 0, dy: 10), display: false)
        }
    }
    
    private func closePopover(_ button: NSButton) {
        let positiongView = statusBarItem.button?.subviews.first { $0.identifier == positioningViewIdentifier() }
        positiongView?.removeFromSuperview()
        
        popover.performClose(button)
    }
    
    private func positioningViewIdentifier() -> NSUserInterfaceItemIdentifier {
        NSUserInterfaceItemIdentifier(rawValue: "snowman.positioningView")
    }
    
    // MARK: AppConfiguration
    
    private func getAppConfiguration() throws -> AppConfiguration {
        let url = Bundle.main.url(forResource: "AppConfiguration", withExtension: "plist")!
        let data = try Data(contentsOf: url)

        return try PropertyListDecoder().decode(AppConfiguration.self, from: data)
    }

}
