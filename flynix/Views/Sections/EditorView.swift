import SwiftUI
import Foundation
import AppKit

struct EditorView: View {
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var scale: CGFloat = 1.0
    @State private var hasZoomAppeared: Bool = false
    @State private var keyDownMonitor: Any?
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            HStack {
                FieldView(
                    backgroundColor: $contentViewModel.originalColor,
                    hasGradient: $contentViewModel.hasGradient,
                    image: $contentViewModel.symbol,
                    tintColor: $contentViewModel.tintColor
                )
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.2), value: scale)
                .help("Click to copy on clipboard")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(alignment: .topTrailing) {
                if hasZoomAppeared {
                    Text("\(String(format: "%.1f", scale))x")
                        .font(.system(size: 20, weight: .black))
                        .foregroundStyle(.white)
                        .padding(.bottom, -500)
                }
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 10) {
                ZoomView(scale: $scale)
                Spacer(minLength: 0)
                DownloadButtonView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("grid")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.3)
        }
        .background(BlurLayer())
        .ignoresSafeArea()
        .onChange(of: scale) { _, _ in
            withAnimation(.easeIn) {
                hasZoomAppeared.toggle()
            }
            
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(0.9))
                
                withAnimation(.easeOut) {
                    hasZoomAppeared.toggle()
                }
            }
        }
        .alert(isPresented: $contentViewModel.hasErrorRenderingImageThrown) {
            Alert(
                title: Text("Image rendering error"),
                message: Text("There was an error rendering image pack. Please try again or relaunch the app."),
                dismissButton: .default(Text("Continue"))
            )
        }
        .alert(isPresented: $contentViewModel.hasErrorCreatingDirectoryThrown) {
            Alert(
                title: Text("Image saving error"),
                message: Text("There was an error saving images on your Mac. Please try again or relaunch the app."),
                dismissButton: .default(Text("Continue"))
            )
        }
        .onAppear {
            keyDownMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                if event.modifierFlags.contains(.command), event.charactersIgnoringModifiers?.lowercased() == "s" {
                    contentViewModel.performDownloadAction()
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
    
    @ViewBuilder private func DownloadButtonView() -> some View {
        Button {
            contentViewModel.performDownloadAction()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "arrow.down.circle.fill")
                Text("Download")
            }
            .font(.title2)
            .foregroundStyle(.black)
            .fontWeight(.heavy)
            .frame(width: 160, height: 55)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.appOriginal)
            }
        }
        .buttonStyle(.plain)
    }
}
