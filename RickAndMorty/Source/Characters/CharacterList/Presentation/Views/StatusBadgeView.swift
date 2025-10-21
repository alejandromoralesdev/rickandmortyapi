import SwiftUI

struct StatusBadgeView: View {
    let status: String

    private var badgeColor: Color {
        switch status.lowercased() {
        case Constants.Character.statusAlive:
            return Color.green
        case Constants.Character.statusDead:
            return Color.red
        default:
            return Color.gray
        }
    }

    var body: some View {
        Text(status.capitalized)
            .font(.caption2)
            .bold()
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(badgeColor.opacity(0.12))
            .foregroundColor(badgeColor)
            .clipShape(Capsule())
    }
}
