import SwiftUI

/// Lumen's secondary button for opaque content (cards, lists): an `accent-soft`
/// capsule with `accent-text` label. On glass, use `.buttonStyle(.glass)` instead.
public struct LumenBorderedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(isEnabled ? Color.Lumen.accentText : Color.Lumen.labelTertiary)
            .padding(.horizontal, Lumen.Space.s5)
            .frame(minHeight: Self.minHeight)
            .background(isEnabled ? Color.Lumen.accentSoft : Color.Lumen.fillTertiary, in: .capsule)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .contentShape(.capsule)
            .animation(.snappy, value: configuration.isPressed)
    }

    private static var minHeight: CGFloat {
        #if os(macOS)
        Lumen.Size.hitMac
        #else
        Lumen.Size.hitIos
        #endif
    }
}

public extension ButtonStyle where Self == LumenBorderedButtonStyle {
    /// `accent-soft` capsule with `accent-text`. For secondary actions on opaque content.
    static var lumenBordered: LumenBorderedButtonStyle { LumenBorderedButtonStyle() }
}
