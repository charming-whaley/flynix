import AppKit

extension NSImage {
    
    var pngData: Data? {
        guard
            let tiffRepresentation = tiffRepresentation,
            let bitmapImageRep = NSBitmapImageRep(data: tiffRepresentation)
        else { return nil }
        
        return bitmapImageRep.representation(
            using: .png,
            properties: [:]
        )
    }
}
