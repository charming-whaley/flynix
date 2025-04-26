import SwiftUI
import AppKit

struct ZoomView: View {
    
    @Binding var scale: CGFloat
    @State private var minimumScale: CGFloat = 0.7
    @State private var maximumScale: CGFloat = 1.5
    @State private var keyDownMonitor: Any?
    
    var body: some View {
        HStack(spacing: 10) {
            Button {
                scale = min(maximumScale, scale + 0.1)
            } label: {
                Image(systemName: "plus.magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .frame(width: 60, height: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                    }
            }
            .buttonStyle(.plain)
            .help("Increase editor size")
            
            Button {
                scale = max(minimumScale, scale - 0.1)
            } label: {
                Image(systemName: "minus.magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .frame(width: 60, height: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                    }
            }
            .buttonStyle(.plain)
            .help("Decrease editor size")
            
            Button {
                scale = 1.0
            } label: {
                Image(systemName: "sparkle.magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .frame(width: 60, height: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                    }
            }
            .buttonStyle(.plain)
            .help("Stadardize editor size")
        }
        .onAppear {
            keyDownMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                if event.modifierFlags.contains(.command), event.charactersIgnoringModifiers == "=" {
                    scale = min(maximumScale, scale + 0.1)
                    return nil
                }
                
                if event.modifierFlags.contains(.command), event.charactersIgnoringModifiers == "-" {
                    scale = max(minimumScale, scale - 0.1)
                    return nil
                }
                
                if event.modifierFlags.contains(.command), event.charactersIgnoringModifiers == "/" {
                    scale = 1.0
                    return nil
                }
                
                return event
            }
        }
        .onDisappear {
            if let monitor = keyDownMonitor {
                NSEvent.removeMonitor(monitor)
                keyDownMonitor = nil
            }
        }
    }
}
