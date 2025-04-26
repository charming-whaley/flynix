import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var activePanel: Panel = .backgroundColor
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 30) {
            CustomSegmentedControl()
            PanelView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
    
    @ViewBuilder private func PanelView() -> some View {
        switch activePanel {
        case .backgroundColor:
            BackgroundPropertiesView(
                currentColor: $contentViewModel.originalColor,
                customColor: $contentViewModel.customColor,
                hasGradient: $contentViewModel.hasGradient
            )
        case .iconSwitcher:
            ImageSwitcherView(
                symbol: $contentViewModel.symbol,
                color: $contentViewModel.tintColor
            )
        case .preferences:
            PropertiesView(
                filename: $contentViewModel.filename,
                hasWatchOSSupport: $contentViewModel.hasWatchOSSupport,
                hasMacOSSupport: $contentViewModel.hasMacOSSupport,
                cornerRadiusPercentage: $contentViewModel.cornerRadiusPercentage
            )
        }
    }
    
    @ViewBuilder private func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            SegmentedControlTab(
                title: Panel.backgroundColor,
                animation: animation,
                activePanel: $activePanel
            )
            
            SegmentedControlTab(
                title: Panel.iconSwitcher,
                animation: animation,
                activePanel: $activePanel
            )
            
            SegmentedControlTab(
                title: Panel.preferences,
                animation: animation,
                activePanel: $activePanel
            )
        }
        .padding(.horizontal)
    }
}
