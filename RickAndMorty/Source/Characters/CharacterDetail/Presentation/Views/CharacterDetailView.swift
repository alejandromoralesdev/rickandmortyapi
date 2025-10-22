import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewModel: CharacterDetailViewModel
    @State private var selectedEpisode: EpisodeCharacterEntity?

    public init(character: CharacterEntity?, characterId: Int? = nil) {
        self._viewModel = StateObject(
            wrappedValue: CharacterDetailViewModel(
                character: character,
                characterId: characterId
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                headerView

                moreInfoCard

                episodesSection
                    .padding(.top, 8)

                Spacer(minLength: 16)
            }
            .padding(.bottom)
        }
        .task {
            await viewModel.loadCharacterDetail()
        }
        .navigationTitle(viewModel.character?.name ?? L10n.Character.unknownName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedEpisode) { episode in
            EpisodeDetailView(episodeId: episode.id, episode: nil)
        }
    }

    private var headerView: some View {
        CharacterHeaderView(character: viewModel.character)
            .padding(.horizontal)
            .padding(.top)
    }

    private var moreInfoCard: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                Group {
                    if let char = viewModel.character {
                        CharacterMoreInfoView(label: L10n.Character.specie, value: char.species)
                        Divider().padding(.horizontal)

                        if let type = char.type, !type.isEmpty {
                            CharacterMoreInfoView(label: L10n.Character.type, value: type)
                            Divider().padding(.horizontal)
                        }

                        CharacterMoreInfoView(label: L10n.Character.gender, value: char.gender)
                        Divider().padding(.horizontal)

                        CharacterMoreInfoView(
                            label: L10n.Character.origin,
                            value: char.origin?.name,
                            isLocation: true,
                            locationId: Utils.originLocationId(from: char.origin?.url) ?? 0
                        )
                        Divider().padding(.horizontal)

                        CharacterMoreInfoView(
                            label: L10n.Character.lastLocation,
                            value: char.location?.name,
                            isLocation: true,
                            locationId: Utils.originLocationId(from: char.location?.url) ?? 0
                        )
                        Divider().padding(.horizontal)

                        CharacterMoreInfoView(label: L10n.Character.created, value: Utils.formattedDate(from: char.created))
                        Divider().padding(.horizontal)

                        if let urlString = char.url, let url = URL(string: urlString) {
                            Link(destination: url) {
                                CharacterMoreInfoView(label: L10n.Character.urlLabel, value: url.host ?? url.absoluteString, isLink: true)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal)
    }

    private var episodesSection: some View {
        EpisodesHorizontalSectionView(
            episodes: viewModel.character?.episode ?? [],
            cardSize: CGSize(width: Constants.Sizes.cardEpisodesSize, height: Constants.Sizes.cardEpisodesSize),
            spacing: Constants.Sizes.episodesSpacing
        ) { epId in
            selectedEpisode = EpisodeCharacterEntity(id: Int(epId) ?? 0, name: "")
        }
    }
}
