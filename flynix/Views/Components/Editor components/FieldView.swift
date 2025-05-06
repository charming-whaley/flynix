import SwiftUI
import AppKit

struct FieldView: View {
    
    @Binding var backgroundColor: Color
    @Binding var hasGradient: Bool
    @Binding var image: String
    @Binding var tintColor: Color
    
    var width: CGFloat = 300
    var height: CGFloat = 300
    var radius: CGFloat = 60
    
    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .fill(hasGradient ? AnyShapeStyle(backgroundColor.gradient) : AnyShapeStyle(backgroundColor))
            .frame(width: width, height: height)
            .overlay(alignment: .center) {
                if !image.isEmpty {
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width / 2, height: height / 2)
                        .foregroundStyle(tintColor)
                }
            }
            .padding()
            .onTapGesture {
                copyToClipboard()
            }
    }
    
    private func copyToClipboard() {
        let size = CGSize(width: 300, height: 300)
        let hostingView = NSHostingView(
            rootView: self.frame(
                width: size.width,
                height: size.height
            )
        )
        hostingView.frame = CGRect(origin: .zero, size: size)
        
        let rep = hostingView.bitmapImageRepForCachingDisplay(in: hostingView.bounds)!
        hostingView.cacheDisplay(in: hostingView.bounds, to: rep)
        
        let image = NSImage(size: size)
        image.addRepresentation(rep)
        
        guard
            let tiffData = image.tiffRepresentation,
            let bitmap = NSBitmapImageRep(data: tiffData),
            let pngData = bitmap.representation(using: .png, properties: [:])
        else {
            return
        }
        
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setData(pngData, forType: .png)
    }
}
