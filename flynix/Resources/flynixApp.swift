import SwiftUI
import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        DispatchQueue.main.async {
            guard let mainMenu = NSApplication.shared.mainMenu else {
                return
            }
            
            var helpMenuItemToRemove: NSMenuItem? = nil
            let helpMenuTitle = NSLocalizedString("Help", comment: "Standard Help menu title")
            
            for menuItem in mainMenu.items {
                if menuItem.title == helpMenuTitle {
                    helpMenuItemToRemove = menuItem
                    break
                }
            }
            
            if let item = helpMenuItemToRemove {
                mainMenu.removeItem(item)
            }
        }
    }
}

@main
struct flynixApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .frame(minWidth: 1280, maxWidth: 1280, minHeight: 720, maxHeight: 720)
                .background(WindowAccessor())
                
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .newItem) {  }
            CommandGroup(replacing: .undoRedo) {  }
            CommandGroup(replacing: .pasteboard) {  }
            CommandGroup(replacing: .help) {  }
        }
    }
}

struct WindowAccessor: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        
        DispatchQueue.main.async {
            if let window = nsView.window {
                window.standardWindowButton(.zoomButton)?.isHidden = true
                window.collectionBehavior.remove(.fullScreenPrimary)
                window.collectionBehavior.remove(.fullScreenAuxiliary)
                window.collectionBehavior = []
                
                NotificationCenter.default.addObserver(
                    forName: NSWindow.didEnterFullScreenNotification,
                    object: window,
                    queue: .main
                ) { _ in
                    window.toggleFullScreen(nil)
                }
            }
        }
        
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {  }
}

