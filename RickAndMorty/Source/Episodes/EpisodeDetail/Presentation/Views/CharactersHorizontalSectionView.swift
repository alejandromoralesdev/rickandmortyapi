//
//  EpisodesHorizontalSection.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 19/10/25.
//

import SwiftUI

struct CharactersHorizontalSectionView: View {
    let characters: [String]?
    let cardSize: CGFloat
    let spacing: CGFloat
    var onCharacterTap: ((String) -> Void)? = nil

    private var rows: [GridItem] {
        [GridItem(.fixed(cardSize))]
    }

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.Sizes.imageWidth), spacing: spacing)], spacing: spacing) {
                    ForEach(validCharacters, id: \.self) { character in
                        // width no se fija: SwiftUI asignará el ancho. Ponemos height fijo para controlar aspecto.
                        CharacterEpisodeSectionCardView(character: character, width: nil, height: Constants.Sizes.rowHeight)
                            .frame(minHeight: Constants.Sizes.rowHeight)
                    }
                }
            }
            
        }
        .padding(.horizontal, 0)
    }

    // Extrae el identificador del episodio (último path component) o devuelve el texto limpio
    private var validCharacters: [String] {
        guard let characters else { return [] }
        
        return characters.compactMap { $0 }.map { chString in
            if let url = URL(string: chString), !url.lastPathComponent.isEmpty {
                return url.lastPathComponent
            }
            return chString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
