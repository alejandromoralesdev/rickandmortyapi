//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 19/10/25.
//

import SwiftUI

struct EpisodeDetailView: View {
    @StateObject private var viewModel: EpisodeDetailViewModel
    
    @State private var selectedCharacter: String?
    
    public init(episode: Int) {
        self._viewModel = StateObject(
            wrappedValue: EpisodeDetailViewModel(episodeId: episode)
        )
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("L10n.Episode.title") // Asegúrate de tener esta clave en L10n
                .font(.title2)
                .bold()
            Text(viewModel.episode.name ?? "")
                .font(.body)
                .foregroundColor(.secondary)
            
            Text("Characters") // Asegúrate de tener esta clave en L10n
                .font(.title2)
                .bold()
            
            CharactersHorizontalSectionView(
                characters: viewModel.episode.characters,
                cardSize: Constants.Sizes.cardCharactersSize,
                spacing: Constants.Sizes.episodesSpacing
            ) { chId in
                // al tocar, asignamos la selección para navegar
                selectedCharacter = chId
            }
            .padding(.top, 4)
            
//            ForEach(viewModel.episode.characters ?? ["hola"], id: \.self) { characterName in
//                CharacterEpisodeSectionCardView(character: String(format: Constants.rickMortyApiImageBaseUrl, viewModel.getCharacterId(characterName)))
//            }
        }
        .task {
            await viewModel.loadEpisode()
        }
        .padding()
        .navigationTitle(String(format: "L10n.Episode.navTitle", viewModel.episodeId)) // opcional
        .navigationBarTitleDisplayMode(.inline)
    }
}
