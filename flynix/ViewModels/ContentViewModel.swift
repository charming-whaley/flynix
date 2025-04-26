import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var hasGradient = false
    @Published var customColor = ""
    @Published var originalColor = Contents.backgrounds.first!.color
    @Published var symbol = Contents.icons.first!
    @Published var tintColor = Color.white
    @Published var filename = "New Icon"
    @Published var hasWatchOSSupport = false
    @Published var hasMacOSSupport = false
    @Published var hasErrorRenderingImageThrown = false
    @Published var hasErrorCreatingDirectoryThrown = false
    @Published var cornerRadiusPercentage: String = ""
    
    func performDownloadAction() {
        var images = [NSImage]()
        if hasWatchOSSupport && !hasMacOSSupport {
            images = (Contents.extendedImageSizesWatchOS).map { size in
                renderIconFieldAsNSImage(
                    withWidth: size.width,
                    AndHeight: size.height,
                    withCornerRadius: Double(cornerRadiusPercentage) ?? 0
                )
            }
        } else if !hasWatchOSSupport && hasMacOSSupport {
            images = (Contents.extendedImageSizesMacOS).map { size in
                renderIconFieldAsNSImage(
                    withWidth: size.width,
                    AndHeight: size.height,
                    withCornerRadius: Double(cornerRadiusPercentage) ?? 0
                )
            }
        } else if hasWatchOSSupport && hasMacOSSupport {
            images = (Contents.extendedImageSizes).map { size in
                renderIconFieldAsNSImage(
                    withWidth: size.width,
                    AndHeight: size.height,
                    withCornerRadius: Double(cornerRadiusPercentage) ?? 0
                )
            }
        } else {
            images = (Contents.standardImageSizes).map { size in
                renderIconFieldAsNSImage(
                    withWidth: size.width,
                    AndHeight: size.height,
                    withCornerRadius: Double(cornerRadiusPercentage) ?? 0
                )
            }
        }
        
        downloadImagesOnComputer(images)
    }
    
    private func renderIconFieldAsNSImage(withWidth width: CGFloat, AndHeight height: CGFloat, withCornerRadius radius: Double) -> NSImage {
        let hostingViewController = NSHostingView(rootView: FieldView(
            backgroundColor: .constant(originalColor),
            hasGradient: .constant(hasGradient),
            image: .constant(symbol),
            tintColor: .constant(tintColor),
            width: width,
            height: height,
            radius: width * radius / 100
        ))
        
        let size = CGSize(width: width, height: height)
        hostingViewController.frame = CGRect(origin: .zero, size: size)
        
        guard let bitmapRep = hostingViewController.bitmapImageRepForCachingDisplay(in: hostingViewController.bounds) else {
            hasErrorRenderingImageThrown.toggle()
            return NSImage()
        }
        hostingViewController.cacheDisplay(in: hostingViewController.bounds, to: bitmapRep)
        
        let image = NSImage(size: size)
        image.addRepresentation(bitmapRep)
        return image
    }
    
    private func downloadImagesOnComputer(_ images: [NSImage]) {
        let panel = NSSavePanel()
        panel.title = "Save on your Mac computer"
        panel.nameFieldStringValue = "\(filename).zip"
        panel.allowedFileTypes = ["zip"]
        
        panel.begin { response in
            if response == .OK, let url = panel.url {
                let fileManager = FileManager.default
                let tempDirectory = fileManager.temporaryDirectory.appendingPathComponent("\(self.filename)")
                
                do {
                    try fileManager.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
                    
                    for (_, image) in images.enumerated() {
                        let imageURL = tempDirectory.appendingPathComponent("\(Int(image.size.width))x\(Int(image.size.height)).png")
                        if let pngData = image.pngData {
                            try pngData.write(to: imageURL)
                        }
                    }
                    
                    let process = Process()
                    process.executableURL = URL(fileURLWithPath: "/usr/bin/ditto")
                    process.arguments = ["-c", "-k", "--sequesterRsrc", "--keepParent", tempDirectory.path, url.path]
                    try process.run()
                    process.waitUntilExit()
                    try fileManager.removeItem(at: tempDirectory)
                } catch {
                    self.hasErrorCreatingDirectoryThrown.toggle()
                    return
                }
            }
        }
    }
}
