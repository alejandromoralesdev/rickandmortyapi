import SwiftUI

struct CharacterMoreInfoView: View {
    let label: String
    let value: String?
    var isLink: Bool = false
    var isLocation: Bool = false
    var locationId: Int = 0

    @State private var isPressed = false
    @State private var showCopiedToast = false
    @State private var selectedLocation: String?

    // MARK: - Computed helpers

    private var trimmed: String? {
        value?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var hasValue: Bool {
        guard let t = trimmed else { return false }
        return !t.isEmpty
    }

    private var displayValue: String {
        hasValue ? trimmed! : L10n.Character.unknownName
    }

    private var indicatorColor: Color {
        hasValue ? .accentColor : Color.secondary.opacity(0.4)
    }

    private var actionImage: Image? {
        if isLink { Image.CharacterDetail.safari }
        else if isLocation { Image.Buttons.rightIcon }
        else if hasValue { Image.CharacterDetail.copy }
        else { nil }
    }

    // MARK: - Actions

    private func openLinkIfNeeded() {
        guard let t = trimmed, hasValue else { return }
        let urlString = t.contains("://") ? t : "https://\(t)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    private func copyOrSelect() {
        guard let t = trimmed, hasValue else { return }
        UIPasteboard.general.string = t
        UINotificationFeedbackGenerator().notificationOccurred(.success)

        if isLocation {
            selectedLocation = String(locationId)
        } else {
            withAnimation { showCopiedToast = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation { showCopiedToast = false }
            }
        }
    }

    // MARK: - Body

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .opacity(0.95)

            VStack(alignment: .leading, spacing: 2) {
                Text(label.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                if !isLink {
                    Text(displayValue)
                        .font(.subheadline)
                        .foregroundColor(hasValue ? .primary : .secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }

            Spacer()

            if let icon = actionImage {
                Button {
                    if isLink { openLinkIfNeeded() }
                    else { copyOrSelect() }
                } label: {
                    icon
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            Group {
                if #available(iOS 15.0, *) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.regularMaterial)
                } else {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(UIColor.secondarySystemBackground))
                }
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .onTapGesture {
            if isLocation { selectedLocation = String(locationId) }
        }
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary.opacity(0.03), lineWidth: 1))
        .overlay(alignment: .topTrailing) {
            if showCopiedToast {
                Text(L10n.Common.copied)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    .shadow(radius: 6, y: 2)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                    .padding(.top, 6)
                    .padding(.trailing, 6)
            }
        }
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 4)
        .scaleEffect(isPressed ? 0.997 : 1.0)
        .animation(.easeInOut(duration: 0.12), value: isPressed)
        .onLongPressGesture(minimumDuration: 0.35, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.12)) { isPressed = pressing }
        }, perform: {
            if hasValue {
                UIPasteboard.general.string = trimmed
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        })
        .accessibilityElement()
        .accessibilityLabel(Text("\(label): \(displayValue)"))
        .navigationDestination(item: $selectedLocation) { location in
            LocationDetailView(locationId: Int(location), location: nil)
        }
    }
}
