import SwiftUI

struct FancyButton: View {
    var title: String
    var subtitle: String? = nil
    var systemIcon: Image? = nil
    var gradient: LinearGradient
    var action: () -> Void

    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }) {
            HStack(spacing: 16) {
                if let icon = systemIcon {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 44, height: 44)
                        icon
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    if let sub = subtitle {
                        Text(sub)
                            .font(.subheadline)
                            .foregroundColor(Color.white.opacity(0.85))
                            .lineLimit(1)
                    }
                }

                Spacer()

                Image.Buttons.rightIcon
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.white.opacity(0.9))
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(gradient)

                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                        .blendMode(.overlay)

                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(LinearGradient(colors: [Color.white.opacity(0.06), Color.clear],
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(0.06), lineWidth: 0.5)
            )
            .shadow(color: Color.black.opacity(0.28), radius: 10, x: 0, y: 8)
        }
        .buttonStyle(PressableButtonStyle())
    }
}
