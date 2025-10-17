import SwiftUI

struct CharacterCardView: View {
    let character: CharacterEntity

    // Ajusta estos valores para dar la proporción que quieras
    static let rowHeight: CGFloat = 140
    static let imageWidth: CGFloat = 120 // ancho "aceptable" para imagen vertical

    var body: some View {
        HStack(spacing: 12) {
            // Imagen que ocupa la altura completa de la card
            AsyncImage(url: URL(string: character.image ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: Self.imageWidth, height: Self.rowHeight)
                        .clipped()
                } else if phase.error != nil {
                    VStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Self.imageWidth * 0.5, height: Self.imageWidth * 0.5)
                            .foregroundColor(.gray)
                    }
                    .frame(width: Self.imageWidth, height: Self.rowHeight)
                    .background(Color(white: 0.95))
                } else {
                    // placeholder
                    ZStack {
                        Color(white: 0.95)
                        ProgressView()
                    }
                    .frame(width: Self.imageWidth, height: Self.rowHeight)
                }
            }
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.06), radius: 3, x: 0, y: 1)

            // Contenido textual
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text(character.name ?? L10n.Character.unknownName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    Spacer()

                    StatusBadgeView(status: character.status ?? L10n.Character.unknownStatus)
                }

                // especie - genero
                HStack(spacing: 8) {
                    Text(character.species ?? L10n.Character.unknownSpecie)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("-")
                        .foregroundColor(.secondary)
                    Text(character.gender ?? L10n.Character.unknownGender)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Origen
                VStack(alignment: .leading, spacing: 2) {
                    Text(L10n.Character.origin)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(character.origin?.name ?? L10n.Character.unknownName)
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }

                // Última ubicación
                VStack(alignment: .leading, spacing: 2) {
                    Text(L10n.Character.lastLocation)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(character.location?.name ?? L10n.Character.unknownLocation)
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }

                Spacer()
            }
            .frame(height: Self.rowHeight)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        )
        .padding(.horizontal, 8)
        .frame(height: Self.rowHeight + 20) // espacio total (imagen + padding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(character.name ?? L10n.Character.name), \(L10n.Character.status) \(character.status ?? L10n.Character.unknownStatus), \(L10n.Character.specie) \(character.species ?? L10n.Character.unknownSpecie)")
    }
}
