import SwiftUI

struct ImageSwitcherView: View {
    
    @Binding var symbol: String
    @Binding var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Content")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.bottom, 16)
            
            IconSwitcherView()
                .padding(.bottom, 16)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Contents.columns, spacing: 16) {
                    ForEach(Contents.icons, id: \.self) { icon in
                        IconView(iconName: icon)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    symbol = icon
                                }
                            }
                            .overlay {
                                if symbol == icon {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 3)
                                        .frame(width: 130, height: 130)
                                        .overlay(alignment: .bottomTrailing) {
                                            Image(systemName: "checkmark.seal.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .padding(10)
                                        }
                                }
                            }
                    }
                }
                .padding([.top, .bottom], 16)
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    @ViewBuilder private func IconSwitcherView() -> some View {
        HStack(spacing: 0) {
            Text("Tint color")
                .font(.system(size: 14))
                .help("Change icon color")
            
            Spacer(minLength: 0)
            
            CustomColorPickerView(color: $color)
                .frame(width: 100, height: 16)
        }
    }
}
