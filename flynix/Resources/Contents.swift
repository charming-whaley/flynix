import SwiftUI

struct Contents {
    
    static let backgrounds = [
        PanelColor(color: .red), PanelColor(color: .orange), PanelColor(color: .yellow), PanelColor(color: .pink), PanelColor(color: .green), PanelColor(color: .cyan), PanelColor(color: .mint), PanelColor(color: .teal), PanelColor(color: .blue), PanelColor(color: .indigo), PanelColor(color: .purple), PanelColor(color: .gray)
    ]
    
    static let icons: [String] = [
        "sun.max.fill", "moon.fill", "sparkles", "moon.stars.fill", "microphone.fill", "message.fill", "quote.bubble.fill", "phone.fill",
        "video.fill", "envelope.fill", "map.fill", "figure.walk.triangle.fill", "tram.fill", "fuelpump.fill", "binoculars.fill", "display.2",
        "macbook.and.iphone", "vision.pro.fill", "homepod.mini.2.fill", "gamecontroller.fill", "car.2.fill", "music.note.tv.fill", "car.fill", "camera.fill",
        "camera.macro", "photo.fill", "flag.pattern.checkered.2.crossed", "icloud.fill", "wifi", "bonjour", "fan.fill", "globe.americas.fill",
        "drop.circle.fill", "hare.fill", "tortoise.fill", "bird.fill", "leaf.fill", "tree.fill", "atom", "heart.fill",
        "cross.fill", "pills.fill", "brain.head.profile.fill", "waveform.path.ecg.rectangle.fill", "compass.drawing", "function", "apple.intelligence", "apple.terminal.fill"
    ]
    
    static let columns = Array(
        repeating: GridItem(
            .fixed(130),
            spacing: 16
        ),
        count: 2
    )
    
    static let standardImageSizes: [ImageSize] = [
        .init(width: 40, height: 40),
        .init(width: 58, height: 58),
        .init(width: 60, height: 60),
        .init(width: 76, height: 76),
        .init(width: 80, height: 80),
        .init(width: 87, height: 87),
        .init(width: 114, height: 114),
        .init(width: 120, height: 120),
        .init(width: 128, height: 128),
        .init(width: 136, height: 136),
        .init(width: 167, height: 167),
        .init(width: 180, height: 180),
        .init(width: 192, height: 192),
        .init(width: 1024, height: 1024)
    ]
    
    static let extendedImageSizesMacOS: [ImageSize] = [
        .init(width: 16, height: 16),
        .init(width: 32, height: 32),
        .init(width: 40, height: 40),
        .init(width: 58, height: 58),
        .init(width: 60, height: 60),
        .init(width: 64, height: 64),
        .init(width: 76, height: 76),
        .init(width: 80, height: 80),
        .init(width: 87, height: 87),
        .init(width: 114, height: 114),
        .init(width: 120, height: 120),
        .init(width: 128, height: 128),
        .init(width: 136, height: 136),
        .init(width: 167, height: 167),
        .init(width: 180, height: 180),
        .init(width: 192, height: 192),
        .init(width: 256, height: 256),
        .init(width: 512, height: 512),
        .init(width: 1024, height: 1024)
    ]
    
    static let extendedImageSizesWatchOS: [ImageSize] = [
        .init(width: 40, height: 40),
        .init(width: 44, height: 44),
        .init(width: 48, height: 48),
        .init(width: 55, height: 55),
        .init(width: 58, height: 58),
        .init(width: 60, height: 60),
        .init(width: 64, height: 64),
        .init(width: 66, height: 66),
        .init(width: 76, height: 76),
        .init(width: 80, height: 80),
        .init(width: 87, height: 87),
        .init(width: 88, height: 88),
        .init(width: 92, height: 92),
        .init(width: 100, height: 100),
        .init(width: 102, height: 102),
        .init(width: 108, height: 108),
        .init(width: 114, height: 114),
        .init(width: 120, height: 120),
        .init(width: 128, height: 128),
        .init(width: 136, height: 136),
        .init(width: 167, height: 167),
        .init(width: 172, height: 172),
        .init(width: 180, height: 180),
        .init(width: 192, height: 192),
        .init(width: 196, height: 196),
        .init(width: 216, height: 216),
        .init(width: 234, height: 234),
        .init(width: 258, height: 258),
        .init(width: 1024, height: 1024)
    ]
    
    static let extendedImageSizes: [ImageSize] = [
        .init(width: 16, height: 16),
        .init(width: 32, height: 32),
        .init(width: 40, height: 40),
        .init(width: 44, height: 44),
        .init(width: 48, height: 48),
        .init(width: 55, height: 55),
        .init(width: 58, height: 58),
        .init(width: 60, height: 60),
        .init(width: 64, height: 64),
        .init(width: 66, height: 66),
        .init(width: 76, height: 76),
        .init(width: 80, height: 80),
        .init(width: 87, height: 87),
        .init(width: 88, height: 88),
        .init(width: 92, height: 92),
        .init(width: 100, height: 100),
        .init(width: 102, height: 102),
        .init(width: 108, height: 108),
        .init(width: 114, height: 114),
        .init(width: 120, height: 120),
        .init(width: 128, height: 128),
        .init(width: 136, height: 136),
        .init(width: 167, height: 167),
        .init(width: 172, height: 172),
        .init(width: 180, height: 180),
        .init(width: 192, height: 192),
        .init(width: 196, height: 196),
        .init(width: 216, height: 216),
        .init(width: 234, height: 234),
        .init(width: 256, height: 256),
        .init(width: 258, height: 258),
        .init(width: 512, height: 512),
        .init(width: 1024, height: 1024)
    ]
}
