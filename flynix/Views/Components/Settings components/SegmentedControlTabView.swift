import SwiftUI

struct SegmentedControlTab: View {
    
    var title: Panel
    var animation: Namespace.ID
    
    @Binding var activePanel: Panel
    
    var body: some View {
        ZStack {
            if activePanel == title {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("AppOriginalColor"))
                    .matchedGeometryEffect(id: "TAB", in: animation)
                    .frame(height: 35)
            }
            
            Image(systemName: title.rawValue)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(activePanel == title ? .black : .white)
                .frame(maxWidth: .infinity, minHeight: 35)
                .contentShape(.rect)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                activePanel = title
            }
        }
    }
}
