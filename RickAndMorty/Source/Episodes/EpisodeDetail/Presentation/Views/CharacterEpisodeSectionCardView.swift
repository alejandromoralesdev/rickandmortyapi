// CharacterCardView.swift
// RickAndMorty
// Adaptado para mostrar varias imágenes por fila manteniendo el nombre original de la clase

import SwiftUI

// --- Clase ORIGINAL (nombre preservado) ---
// Ahora es reutilizable: acepta width/height opcionales (con valores por defecto para compatibilidad)
struct CharacterEpisodeSectionCardView: View {
    let character: String
    var width: CGFloat? = nil      // opcional: si se pasa, se usa para el frame; si no, se usan Constants
    var height: CGFloat? = nil     // opcional

    // Valores por defecto (usa tus constantes si las tienes)
    private var defaultImageWidth: CGFloat { Constants.Sizes.imageWidth }
    private var defaultRowHeight: CGFloat { Constants.Sizes.rowHeight }

    var body: some View {
        // Valores de estilo
        let imageCornerRadius: CGFloat = 12
        let cardCornerRadius: CGFloat = 14

        // Determinar dimensiones efectivas
        let effectiveWidth = width ?? defaultImageWidth
        let effectiveHeight = height ?? defaultRowHeight

        HStack(spacing: 4) {
            AsyncImage(url: Constants.Endpoints.getImageURL(id: character)) { phase in
                Group {
                    switch phase {
                    case .empty:
                        ZStack {
                            Color(white: 0.95)
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        ZStack {
                            Color(white: 0.95)
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .padding(effectiveWidth * 0.1)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: effectiveWidth, height: effectiveHeight)
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius, style: .continuous))
                .compositingGroup()
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
            }
        }
        .frame(height: effectiveHeight)
        .background(
            RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous)
                .fill(Color.Main.backgroundCard)
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

// --- Variante adaptativa (opcional): SwiftUI decide cuántas columnas caben) ---
struct CharacterGridAdaptiveView: View {
    let characters: [String]
    let minimumItemWidth: CGFloat    // p.ej. 100 -> cabrán tantas columnas como entren
    let spacing: CGFloat = 12
    let rowHeight: CGFloat

    init(characters: [String], minimumItemWidth: CGFloat = 100, rowHeight: CGFloat = Constants.Sizes.rowHeight) {
        self.characters = characters
        self.minimumItemWidth = minimumItemWidth
        self.rowHeight = rowHeight
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumItemWidth), spacing: spacing)], spacing: spacing) {
                ForEach(characters, id: \.self) { character in
                    // width no se fija: SwiftUI asignará el ancho. Ponemos height fijo para controlar aspecto.
                    CharacterEpisodeSectionCardView(character: character, width: 50, height: rowHeight)
                        .frame(minHeight: rowHeight)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
