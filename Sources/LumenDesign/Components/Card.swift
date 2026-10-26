import SwiftUI

struct LumenCard: ViewModifier {
    let padding: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(Color.Lumen.surface, in: .rect(cornerRadius: Lumen.Radius.l, style: .continuous))
            .containerShape(.rect(cornerRadius: Lumen.Radius.l, style: .continuous))
    }
}

public extension View {
    /// An opaque `surface` card with `radius-l` corners. Inner shapes clipped with
    /// `ConcentricRectangle()` get the concentric radius (radius-l minus `padding`).
    func lumenCard(padding: CGFloat = Lumen.Space.s4) -> some View {
        modifier(LumenCard(padding: padding))
    }
}
