import SwiftUI

public extension Lumen {
    /// The ground a screen sits on. Each maps to a Lumen colour token.
    enum Ground: Sendable {
        /// `bg`: plain lists, full-bleed content, media.
        case plain
        /// `bg-grouped`: inset-grouped lists, forms and settings screens.
        case grouped
        /// `bg-window`: the content area of a Mac window.
        case window

        public var color: Color {
            switch self {
            case .plain: Color.Lumen.bg
            case .grouped: Color.Lumen.bgGrouped
            case .window: Color.Lumen.bgWindow
            }
        }
    }
}

struct LumenBackground: ViewModifier {
    let ground: Lumen.Ground

    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(ground.color.ignoresSafeArea())
    }
}

public extension View {
    /// Paints a screen with a Lumen ground instead of the system's white.
    /// Apply it to the `List`, `Form` or `ScrollView` itself (not to the `NavigationStack`):
    /// it hides the scroll view's own background and fills edge to edge under the bars.
    ///
    ///     List { … }
    ///         .listStyle(.insetGrouped)
    ///         .lumenBackground()          // bg-grouped
    ///
    /// Pair it with `.lumenRowBackground()` on each `Section` so rows use `surface`.
    func lumenBackground(_ ground: Lumen.Ground = .grouped) -> some View {
        modifier(LumenBackground(ground: ground))
    }

    /// Gives list and form rows Lumen's `surface` colour instead of the system's white.
    /// Apply it to a `Section` or `ForEach`; it covers every row inside.
    func lumenRowBackground() -> some View {
        listRowBackground(Color.Lumen.surface)
    }
}
