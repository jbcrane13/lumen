import SwiftUI

/// A status message that always pairs colour with an SF Symbol, so colour is never the only signal.
public struct LumenStatusLabel: View {
    public enum Status: Sendable {
        case success, warning, danger

        var color: Color {
            switch self {
            case .success: Color.Lumen.success
            case .warning: Color.Lumen.warning
            case .danger: Color.Lumen.danger
            }
        }

        var symbol: String {
            switch self {
            case .success: "checkmark.circle.fill"
            case .warning: "exclamationmark.triangle.fill"
            case .danger: "xmark.octagon.fill"
            }
        }
    }

    private let title: LocalizedStringKey
    private let status: Status

    public init(_ title: LocalizedStringKey, status: Status) {
        self.title = title
        self.status = status
    }

    public var body: some View {
        Label(title, systemImage: status.symbol)
            .foregroundStyle(status.color)
    }
}
