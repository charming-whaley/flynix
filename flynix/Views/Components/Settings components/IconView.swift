import SwiftUI

struct IconView: View {
    
    let iconName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.black)
            .stroke(.white, lineWidth: 1)
            .frame(height: 130)
            .frame(maxWidth: .infinity)
            .overlay {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
            }
    }
}
