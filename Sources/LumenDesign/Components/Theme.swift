import SwiftUI

public extension View {
    /// Applies Lumen to a whole app or window: the accent tint for every control,
    /// tab, link and glass-prominent button below it. Call once at the root.
    ///
    ///     WindowGroup { ContentView().lumenTheme() }
    func lumenTheme() -> some View {
        tint(Color.Lumen.accent)
    }
}

public extension Font {
    /// Lumen's text styles: SwiftUI's Dynamic Type styles with Lumen's weights.
    /// They resolve to the iOS or macOS sizes from tokens.json automatically.
    enum Lumen {
        public static let largeTitle = Font.largeTitle.bold()
        public static let title = Font.title.bold()
        public static let title2 = Font.title2.bold()
        public static let title3 = Font.title3.weight(.semibold)
        public static let headline = Font.headline
        public static let body = Font.body
        public static let callout = Font.callout
        public static let subheadline = Font.subheadline
        public static let footnote = Font.footnote
        public static let caption = Font.caption
        public static let caption2 = Font.caption2
        public static let code = Font.system(.body, design: .monospaced)
    }
}

/// `numeric-display`: SF Pro Rounded bold at 48pt, scaled with Dynamic Type, monospaced digits.
struct NumericDisplay: ViewModifier {
    @ScaledMetric(relativeTo: .largeTitle) private var size: CGFloat = 48

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .bold, design: .rounded))
            .monospacedDigit()
            .contentTransition(.numericText())
    }
}

public extension View {
    /// Styles changing numbers (stats, timers, widgets) as Lumen's `numeric-display`.
    func lumenNumericDisplay() -> some View {
        modifier(NumericDisplay())
    }
}
