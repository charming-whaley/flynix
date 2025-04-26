import SwiftUI

struct CustomPaletteBoxView: View {
    
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color.gradient)
            .frame(maxWidth: .infinity)
            .frame(height: 130)
    }
}
