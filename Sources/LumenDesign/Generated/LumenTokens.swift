// Generated from Design/tokens.json by Scripts/generate_tokens.py. Do not edit by hand.
import SwiftUI
public extension Color {
    /// Lumen colour tokens. Each resolves its Light or Dark value from the current appearance.
    enum Lumen {
        /// Plain lists, full-bleed content and the iOS screen behind everything. SwiftUI: Color(.systemBackground).
        public static let bg = Color(light: RGBA(255, 255, 255, 1), dark: RGBA(0, 0, 0, 1))
        /// Behind inset-grouped lists and settings screens. SwiftUI: Color(.systemGroupedBackground).
        public static let bgGrouped = Color(light: RGBA(242, 242, 247, 1), dark: RGBA(0, 0, 0, 1))
        /// macOS window content area behind the floating sidebar and inspector.
        public static let bgWindow = Color(light: RGBA(245, 245, 247, 1), dark: RGBA(29, 29, 31, 1))
        /// Rows and cards on bg-grouped; sheet content. SwiftUI: Color(.secondarySystemGroupedBackground).
        public static let surface = Color(light: RGBA(255, 255, 255, 1), dark: RGBA(28, 28, 30, 1))
        /// Content nested inside a surface (a field inside a card, a popover row).
        public static let surfaceRaised = Color(light: RGBA(242, 242, 247, 1), dark: RGBA(44, 44, 46, 1))
        /// Thin control fills: switch track off, slider track. SwiftUI: Color(.systemFill).
        public static let fill = Color(light: RGBA(120, 120, 128, 0.2), dark: RGBA(120, 120, 128, 0.36))
        /// Medium fills: grabbers, progress tracks.
        public static let fillSecondary = Color(light: RGBA(120, 120, 128, 0.16), dark: RGBA(120, 120, 128, 0.32))
        /// Large fills: segmented-control track, search field outside glass, pressed row.
        public static let fillTertiary = Color(light: RGBA(118, 118, 128, 0.12), dark: RGBA(118, 118, 128, 0.24))
        /// Primary text and glyphs on every ground and on glass. SwiftUI: .primary.
        public static let label = Color(light: RGBA(0, 0, 0, 1), dark: RGBA(255, 255, 255, 1))
        /// Subtitles, row values, captions on bg, bg-grouped, surface and surface-raised (4.5:1 or better in both themes). Darker than SwiftUI .secondary on purpose.
        public static let labelSecondary = Color(light: RGBA(110, 110, 115, 1), dark: RGBA(152, 152, 157, 1))
        /// Placeholder text, disabled labels and chevrons only. Below 4.5:1 by design; never for information a person must read.
        public static let labelTertiary = Color(light: RGBA(174, 174, 178, 1), dark: RGBA(99, 99, 102, 1))
        /// 0.5pt hairlines between list rows and toolbar groups. SwiftUI: Color(.separator).
        public static let separator = Color(light: RGBA(60, 60, 67, 0.29), dark: RGBA(84, 84, 88, 0.65))
        /// Hairlines that must not tint with what is behind them (table headers on macOS).
        public static let separatorOpaque = Color(light: RGBA(198, 198, 200, 1), dark: RGBA(56, 56, 58, 1))
        /// The app tint: prominent button fills, selected tab glyph, switch on, slider fill. Holds white text at 4.5:1+ in both themes. Set as AccentColor in the asset catalog.
        public static let accent = Color(light: RGBA(0, 102, 204, 1), dark: RGBA(0, 113, 227, 1))
        /// Tinted text and glyphs (links, plain buttons, toolbar items) on bg, surface and glass. 5:1+ light, 5.2:1+ dark.
        public static let accentText = Color(light: RGBA(0, 102, 204, 1), dark: RGBA(75, 161, 255, 1))
        /// Text and glyphs on an accent fill.
        public static let onAccent = Color(light: RGBA(255, 255, 255, 1), dark: RGBA(255, 255, 255, 1))
        /// Selected sidebar row, tinted bordered button, selection highlight. Opaque so its text holds contrast on any ground or glass: accent-text on it is 4.8:1 light, 5.0:1 dark.
        public static let accentSoft = Color(light: RGBA(229, 239, 250, 1), dark: RGBA(18, 48, 79, 1))
        /// Keyboard focus ring on iPad and Mac: 3pt solid, 3:1+ on every ground in both themes.
        public static let focusRing = Color(light: RGBA(0, 102, 204, 1), dark: RGBA(75, 161, 255, 1))
        /// Confirmations, positive deltas, paired with checkmark.circle. Text-safe on bg, bg-grouped and surface.
        public static let success = Color(light: RGBA(29, 122, 51, 1), dark: RGBA(48, 209, 88, 1))
        /// Recoverable problems, paired with exclamationmark.triangle. Text-safe on bg, bg-grouped and surface.
        public static let warning = Color(light: RGBA(178, 80, 0, 1), dark: RGBA(255, 179, 64, 1))
        /// Destructive actions and errors, paired with a word or xmark.octagon. Text-safe on bg, bg-grouped and surface.
        public static let danger = Color(light: RGBA(215, 0, 21, 1), dark: RGBA(255, 105, 97, 1))
        /// Web/preview stand-in for Liquid Glass (.glassEffect()). In SwiftUI never paint this: use the system material.
        public static let glassFill = Color(light: RGBA(255, 255, 255, 0.62), dark: RGBA(44, 44, 46, 0.55))
        /// 0.5pt rim on glass stand-ins; also the inner ring on the cover.
        public static let glassStroke = Color(light: RGBA(255, 255, 255, 0.85), dark: RGBA(255, 255, 255, 0.16))
        /// 1pt top specular edge on glass stand-ins and prominent buttons.
        public static let glassHighlight = Color(light: RGBA(255, 255, 255, 0.9), dark: RGBA(255, 255, 255, 0.22))
        /// Dims content behind a large-detent sheet or alert.
        public static let scrim = Color(light: RGBA(0, 0, 0, 0.2), dark: RGBA(0, 0, 0, 0.48))
    }
}

public extension Lumen {
    enum Space {
        /// Icon-to-label gap inside compact controls; badge padding.
        public static let s1: CGFloat = 4
        /// Gap between related controls; HStack default for toolbar items; glass container spacing.
        public static let s2: CGFloat = 8
        /// Row vertical padding on Mac; gap between cards in a grid.
        public static let s3: CGFloat = 12
        /// iPhone layout margin; list row horizontal padding; card padding.
        public static let s4: CGFloat = 16
        /// iPad and Mac layout margin; sheet content padding.
        public static let s5: CGFloat = 20
        /// Gap between sections inside a scroll view.
        public static let s6: CGFloat = 24
        /// Gap above a section heading; empty-state padding.
        public static let s8: CGFloat = 32
        /// Hero spacing on onboarding and Mac welcome windows.
        public static let s12: CGFloat = 48
    }
    enum Radius {
        /// Small Mac controls, badges, inline code.
        public static let xs: CGFloat = 6
        /// Text fields and pop-up buttons on Mac; app-icon tiles in rows.
        public static let s: CGFloat = 10
        /// Thumbnails, menus, popovers; inner shapes inside radius-l containers (radius-l minus 8pt padding).
        public static let m: CGFloat = 16
        /// Inset-grouped list sections, cards, Mac floating sidebar.
        public static let l: CGFloat = 24
        /// Sheets and large glass panels on iPhone; the outermost container a screen shows.
        public static let xl: CGFloat = 34
        /// Hero tiles and onboarding panels on iPad; the cover's outer panel.
        public static let s2xl: CGFloat = 48
        /// Capsules: buttons, tab bars, search fields, segmented controls, toolbar groups. SwiftUI: .capsule.
        public static let full: CGFloat = 9999
    }
    enum Size {
        /// Minimum touch target on iPhone and iPad (both axes).
        public static let hitIos: CGFloat = 44
        /// Default control height and minimum click target on Mac.
        public static let hitMac: CGFloat = 28
        /// Height of .controlSize(.large) prominent buttons pinned to the bottom of a screen.
        public static let controlLarge: CGFloat = 50
        /// Floating glass tab bar height on iPhone.
        public static let tabBar: CGFloat = 62
    }
}
