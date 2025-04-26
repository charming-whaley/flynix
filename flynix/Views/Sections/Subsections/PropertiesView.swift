import SwiftUI

struct PropertiesView: View {
    
    @Binding var filename: String
    @Binding var hasWatchOSSupport: Bool
    @Binding var hasMacOSSupport: Bool
    @Binding var cornerRadiusPercentage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Additional")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.bottom, 16)
            
            TextField("File name", text: $filename)
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.appEditorBackground)
                }
                .padding(.bottom, 10)
            
            Group {
                CustomToggleView(
                    switcher: $hasMacOSSupport,
                    title: "Add macOS icon sizes"
                )
                .padding(.bottom, 10)
                
                CustomToggleView(
                    switcher: $hasWatchOSSupport,
                    title: "Add watchOS icon sizes"
                )
                .padding(.bottom, 16)
            }
            .padding(.leading, 8)
            
            TextField("Corner radius (0 - 100%)", text: $cornerRadiusPercentage)
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.appEditorBackground)
                }
                .help("You can add from 0 to 100% of your current width as corner radius")
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
