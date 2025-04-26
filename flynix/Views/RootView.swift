import SwiftUI

struct RootView: View {
    
    @StateObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        GeometryReader {
            let window = $0.size.width
            
            HStack(spacing: 0) {
                EditorView()
                    .frame(width: window * 3 / 4)
                    .environmentObject(contentViewModel)
                
                Divider()
                    .foregroundStyle(Color.secondary)
                    .ignoresSafeArea()
                
                SettingsView()
                    .frame(width: window / 4)
                    .environmentObject(contentViewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(.dark)
    }
}
