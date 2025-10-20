import SwiftUI

struct EpisodeCardView: View {
    let numberText: String
    let size: CGFloat

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            // Fondo con degradado ligero
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(backgroundGradient)
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.12 : 0.06),
                        radius: 8, x: 0, y: 4)

            // Número grande en el fondo como adorno
            Text(numberText)
                .font(.system(size: size * 0.48, weight: .black, design: .rounded))
                .foregroundColor(Color.Main.episodeCardText)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
//                .offset(x: size * 0.08, y: -size * 0.12)
                .allowsHitTesting(false)

//            VStack(alignment: .leading, spacing: 6) {
//                HStack {
//                    Circle()
//                        .fill(Color.white.opacity(0.12))
//                        .frame(width: 34, height: 34)
//                        .overlay(Image(systemName: "film").foregroundColor(accentColor))
//                    Spacer()
//                }
//
//                Text("Episode \(numberText)")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.primary)
//                    .lineLimit(2)
//
//                Spacer()
//
//                Text("L10n.Common.tapToOpen") // "Tap to open" o tu localización
//                    .font(.caption2)
//                    .foregroundColor(.secondary)
//            }
//            .padding(12)
//            .frame(width: size, height: size, alignment: .leading)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//        .scaleEffect(isPressed ? 0.985 : 1.0)
//        .animation(.spring(response: 0.28, dampingFraction: 0.7), value: isPressed)
        // small pressed effect for Button
        .accessibilityElement()
        .accessibilityLabel(Text("String(format: L10n.Episode.accessibilityLabel, numberText)"))
    }

    // MARK: - Helpers
    private var accentColor: Color {
        colorScheme == .dark ? .yellow : .blue
    }

    private var backgroundGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(colors: [Color.blue.opacity(0.20), Color.purple.opacity(0.14)], startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(colors: [Color.blue.opacity(0.96), Color.purple.opacity(0.86)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
