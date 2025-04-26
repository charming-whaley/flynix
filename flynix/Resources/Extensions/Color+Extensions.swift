import SwiftUI

extension Color {
    
    init?(hex: String) {
        guard let uiColor = NSColor(hex: hex) else { return nil }
        self.init(nsColor: uiColor)
    }
    
    public func toHexString(includeAlpha: Bool = false) -> String? {
        return NSColor(self).toHexString(includeAlpha: includeAlpha)
    }
}
