import SwiftUI

struct CustomToggleView: View {
    
    @Binding var switcher: Bool
    let title: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: switcher ? "checkmark.square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundStyle(switcher ? .appOriginal : .white)
            
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(switcher ? .appOriginal : .white)
        }
        .onTapGesture {
            switcher.toggle()
        }
    }
}
