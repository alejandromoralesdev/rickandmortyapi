import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewModel: CharacterDetailViewModel

    // Selección para navegación hacia EpisodeDetailView
    @State private var selectedEpisode: EpisodeEntity?

    public init(character: CharacterEntity) {
        self._viewModel = StateObject(
            wrappedValue: CharacterDetailViewModel(character: character)
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header visual renovado
                CharacterHeaderView(character: viewModel.character)
                    .padding(.horizontal)
                    .padding(.top)

                // Card de información principal (uso tus CharacterMoreInfoView)
                VStack(spacing: 8) {
                    // Agrupamos las filas dentro de una card con fondo semitransparente/blur
                    VStack(spacing: 0) {
                        Group {
                            CharacterMoreInfoView(label: L10n.Character.specie, value: viewModel.character.species)
                            Divider().padding(.horizontal)
                            CharacterMoreInfoView(label: L10n.Character.type, value: Utils.nonEmpty(viewModel.character.type))
                            Divider().padding(.horizontal)
                            CharacterMoreInfoView(label: L10n.Character.gender, value: viewModel.character.gender)
                            Divider().padding(.horizontal)
                            CharacterMoreInfoView(label: L10n.Character.origin, value: viewModel.character.origin?.name)
                            Divider().padding(.horizontal)
                            CharacterMoreInfoView(label: L10n.Character.lastLocation, value: viewModel.character.location?.name)
                            Divider().padding(.horizontal)
                            CharacterMoreInfoView(label: L10n.Character.created, value: Utils.formattedDate(from: viewModel.character.created))
                            Divider().padding(.horizontal)
                            if let urlString = viewModel.character.url, let url = URL(string: urlString) {
                                Link(destination: url) {
                                    CharacterMoreInfoView(label: L10n.Character.urlLabel, value: url.host ?? url.absoluteString, isLink: true)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal)

                // Sección de episodios (mantengo tu EpisodesHorizontalSectionView)
                EpisodesHorizontalSectionView(
                    episodes: viewModel.character.episode,
                    cardSize: CGSize(width: Constants.Sizes.cardEpisodesSize, height: Constants.Sizes.cardEpisodesSize),
                    spacing: Constants.Sizes.episodesSpacing
                ) { epId in
                    selectedEpisode = EpisodeEntity(id: Int(epId) ?? 0)
                }
                .padding(.top, 8)

                Spacer(minLength: 16)
            }
            .padding(.bottom)
        }
        .navigationTitle(viewModel.character.name ?? L10n.Character.unknownName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedEpisode) { episode in
            EpisodeDetailView(episode: episode.id)
        }
    }
}
