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
            Text(L10n.Episodes.title)
                .font(.title2)
                .bold()
            Text(viewModel.episode.name ?? "")
                .font(.body)
                .foregroundColor(.secondary)
            
            Text(L10n.Common.characters)
                .font(.title2)
                .bold()
            
            CharactersHorizontalSectionView(
                characters: viewModel.episode.characters,
                cardSize: Constants.Sizes.cardCharactersSize,
                spacing: Constants.Sizes.episodesSpacing
            ) { chId in
                selectedCharacter = chId
            }
            .padding(.top, 4)
        }
        .task {
            await viewModel.loadEpisode()
        }
        .padding()
        .navigationTitle(viewModel.episode.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedCharacter) { characterId in
            CharacterDetailView(character: nil, characterId: Int(characterId))
        }
    }
}
