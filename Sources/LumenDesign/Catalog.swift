import SwiftUI

/// A screen showing every Lumen token and component, for checking the system in a running app or preview.
public struct LumenCatalog: View {
    @State private var notifications = true
    @State private var range = "Week"

    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                Section("Buttons") {
                    HStack(spacing: Lumen.Space.s2) {
                        Button("Continue") {}
                            .buttonStyle(.glassProminent)
                        Button("Not Now") {}
                            .buttonStyle(.glass)
                        Button("Add", systemImage: "plus") {}
                            .buttonStyle(.glass)
                            .labelStyle(.iconOnly)
                            .buttonBorderShape(.circle)
                    }
                    HStack(spacing: Lumen.Space.s2) {
                        Button("Add Photos") {}
                            .buttonStyle(.lumenBordered)
                        Button("Learn More") {}
                            .buttonStyle(.borderless)
                    }
                }

                Section {
                    Toggle(isOn: $notifications) {
                        Label { Text("Allow Notifications") } icon: { LumenSettingsIcon("bell.fill") }
                    }
                    LabeledContent {
                        Text("On")
                    } label: {
                        Label { Text("Sync") } icon: { LumenSettingsIcon("wifi") }
                    }
                    Picker("Range", selection: $range) {
                        ForEach(["Day", "Week", "Month", "Year"], id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Controls")
                } footer: {
                    Text("Toggles and pickers take the accent from lumenTheme().")
                }

                Section("Status") {
                    LumenStatusLabel("Backed up today", status: .success)
                    LumenStatusLabel("Storage almost full", status: .warning)
                    LumenStatusLabel("Couldn't sync", status: .danger)
                }

                Section("Card") {
                    VStack(alignment: .leading, spacing: Lumen.Space.s1) {
                        Text("Steps today")
                            .font(Font.Lumen.subheadline)
                            .foregroundStyle(Color.Lumen.labelSecondary)
                        Text(12_480, format: .number)
                            .lumenNumericDisplay()
                        LumenStatusLabel("Goal reached", status: .success)
                            .font(Font.Lumen.subheadline.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lumenCard()
                    .listRowBackground(Color.Lumen.bgGrouped)
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Lumen")
        }
        .lumenTheme()
    }
}

#Preview("Light") {
    LumenCatalog()
}

#Preview("Dark") {
    LumenCatalog()
        .preferredColorScheme(.dark)
}
