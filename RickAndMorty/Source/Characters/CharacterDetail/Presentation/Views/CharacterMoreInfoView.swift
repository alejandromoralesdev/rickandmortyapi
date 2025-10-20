import SwiftUI

struct CharacterMoreInfoView: View {
    let label: String
    let value: String?
    var isLink: Bool = false
    
    // Small pressed effect state (optional)
    @State private var isPressed: Bool = false
    @State private var showCopiedToast: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Left indicator: pequeño punto que refleja si hay valor o no
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .opacity(0.95)
            
            VStack(alignment: .leading, spacing: 2) {
                // Label (small, less prominent)
                Text(label.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                // Value (más legible)
                if !isLink {
                    Text(displayValue)
                        .font(.subheadline)
                        .foregroundColor(value == nil ? .secondary : .primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
            
            // Optional affordance: si hay valor, mostramos un pequeño botón para copiar
            if isLink {
                Button(action: {
                    // Optional: simple haptic feedback
                    if let value,
                       let url = URL(string: "https://\(value)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image(systemName: "safari")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text("Abrir \(label)"))
            } else if let nonEmpty = value?.trimmingCharacters(in: .whitespacesAndNewlines), !nonEmpty.isEmpty {
                Button(action: {
                    UIPasteboard.general.string = nonEmpty
                    // Optional: simple haptic feedback
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    withAnimation {
                        showCopiedToast = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation {
                            showCopiedToast = false
                        }
                    }
                }) {
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text("Copiar \(label)"))
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(backgroundView)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primary.opacity(0.03), lineWidth: 1)
        )
        .overlay(alignment: .topTrailing, content: {
            if showCopiedToast {
                Text("Copiado")
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
        })
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 4)
        .scaleEffect(isPressed ? 0.997 : 1.0)
        .animation(.easeInOut(duration: 0.12), value: isPressed)
        .onLongPressGesture(minimumDuration: 0.35, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.12)) {
                isPressed = pressing
            }
        }, perform: {
            // long press action: copy value (if present)
            if let nonEmpty = value?.trimmingCharacters(in: .whitespacesAndNewlines), !nonEmpty.isEmpty {
                UIPasteboard.general.string = nonEmpty
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
        })
        .accessibilityElement()
        .accessibilityLabel(Text("\(label): \(displayValue)"))
    }
    
    // MARK: - Helpers
    
    private var displayValue: String {
        if let v = value, !v.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return v
        } else {
            return L10n.Character.unknownName
        }
    }
    
    private var indicatorColor: Color {
        if let v = value, !v.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return Color.accentColor
        } else {
            return Color.secondary.opacity(0.4)
        }
    }
    
    // Use .regularMaterial on iOS 15+, fallback to systemBackground
    @ViewBuilder
    private var backgroundView: some View {
        if #available(iOS 15.0, *) {
            // regularMaterial respeta el modo oscuro y tiene buen resultado visual
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.regularMaterial)
        } else {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
        }
    }
}
