import SwiftUI

/// The 30pt `accent` tile with a white SF Symbol used as a list row's icon.
///
///     Label { Text("Profile") } icon: { LumenSettingsIcon("person.fill") }
public struct LumenSettingsIcon: View {
    private let systemName: String

    public init(_ systemName: String) {
        self.systemName = systemName
    }

    public var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(Color.Lumen.onAccent)
            .frame(width: 30, height: 30)
            .background(Color.Lumen.accent, in: .rect(cornerRadius: 8, style: .continuous))
            .accessibilityHidden(true)
    }
}
