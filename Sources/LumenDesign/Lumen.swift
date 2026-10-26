import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Namespace for Lumen's spacing, radius and size tokens (`Lumen.Space.l`, `Lumen.Radius.l`).
/// Colours live on `Color.Lumen`.
public enum Lumen {}

/// An sRGB colour with 0–255 channels and 0–1 alpha, as written in tokens.json.
struct RGBA: Sendable {
    let r: Double, g: Double, b: Double, a: Double

    init(_ r: Double, _ g: Double, _ b: Double, _ a: Double) {
        (self.r, self.g, self.b, self.a) = (r, g, b, a)
    }

    #if canImport(UIKit)
    var platformColor: UIColor { UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a) }
    #elseif canImport(AppKit)
    var platformColor: NSColor { NSColor(srgbRed: r / 255, green: g / 255, blue: b / 255, alpha: a) }
    #endif
}

extension Color {
    /// A colour that follows the system appearance, choosing `dark` in Dark Mode.
    init(light: RGBA, dark: RGBA) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? dark.platformColor : light.platformColor
        })
        #elseif canImport(AppKit)
        self.init(nsColor: NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua ? dark.platformColor : light.platformColor
        })
        #endif
    }
}
