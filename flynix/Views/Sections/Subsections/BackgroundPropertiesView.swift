import SwiftUI

struct BackgroundPropertiesView: View {
    
    @Binding var currentColor: Color
    @Binding var customColor: String
    @Binding var hasGradient: Bool
    @State private var showErrorAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Background")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.bottom, 16)
            
            CustomColorView()
                .padding(.bottom, 10)
            
            CustomToggleView(
                switcher: $hasGradient,
                title: "Add gradient to the background"
            )
            .padding(.bottom, 14)
            .padding(.leading, 8)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Contents.columns, spacing: 16) {
                    ForEach(Contents.backgrounds) { palette in
                        CustomPaletteBoxView(palette.color)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    currentColor = palette.color
                                }
                            }
                            .overlay {
                                if currentColor == palette.color, customColor.isEmpty {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 2)
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
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Incorrect color format"),
                message: Text("You've entered a wrong color format! Please enter a vlid HEX color code."),
                dismissButton: .default(Text("Continue"))
            )
        }
    }
    
    @ViewBuilder private func CustomColorView() -> some View {
        HStack(spacing: 8) {
            TextField("HEX code", text: $customColor)
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("AppEditorBackgroundColor"))
                }
            
            Button {
                if let customColor = Color(hex: customColor) {
                    currentColor = customColor
                } else {
                    showErrorAlert.toggle()
                }
            } label: {
                Image(systemName: "paintbrush.pointed.fill")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                    .padding(.vertical, 10)
                    .frame(width: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("AppOriginalColor"))
                    }
            }
            .buttonStyle(.plain)
        }
    }
}
