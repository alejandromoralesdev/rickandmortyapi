import SwiftUI

struct CharacterHeaderView: View {
    let character: CharacterEntity?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(LinearGradient(
                    colors: gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .opacity(0.08)
            
            HStack(spacing: 16) {
                avatar
                    .frame(width: Constants.Sizes.imageSize, height: Constants.Sizes.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)

                VStack(alignment: .leading, spacing: 8) {
                    Text(character?.name ?? L10n.Character.unknownName)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    HStack(spacing: 8) {
                        Utils.statusBadge(for: character?.status)
                        Text(character?.status ?? L10n.Character.unknownStatus)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    if let species = character?.species, !species.isEmpty {
                        Text(species)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }

    private var avatar: some View {
        AsyncImage(url: URL(string: character?.image ?? "")) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color(UIColor.systemGray5)
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                ZStack {
                    Color(UIColor.systemGray5)
                    Image.Errors.noPhoto
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                        .foregroundColor(.gray)
                }
            @unknown default:
                EmptyView()
            }
        }
        .accessibilityLabel(Text(character?.name ?? L10n.Character.unknownName))
    }

    private var gradientColors: [Color] {
        [Color.accentColor.opacity(0.12), Color.primary.opacity(0.02)]
    }
}
