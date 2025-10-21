import Foundation

@MainActor
class EpisodeDetailViewModel: ObservableObject {
    @Published var episode: EpisodeEntity?
    @Published var isLoadingPage: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    @Published var episodeId: Int?

    private let getEpisodeDetailUseCase: GetEpisodeDetailUseCase

    public init(
        episodeId: Int? = nil,
        episode: EpisodeEntity? = nil,
        getEpisodeDetailUseCase: GetEpisodeDetailUseCase = GetEpisodeDetailUseCase()
    ) {
        self.episode = episode
        self.episodeId = episodeId
        self.getEpisodeDetailUseCase = getEpisodeDetailUseCase
    }

    func loadEpisode() async {
        if episode != nil { return }
        guard let episodeId else { return }
        isLoadingPage = true
        errorMessage = nil

        await fetchEpisode(episode: episodeId)
        isLoadingPage = false
    }
    
    func getCharacterId(_ characterUrl: String) -> String {
        var chString = ""
        
        if let url = URL(string: characterUrl), !url.lastPathComponent.isEmpty {
            chString = url.lastPathComponent
        }
        
        return chString
    }

    private func fetchEpisode(episode: Int) async {
        do {
            self.episode = try await getEpisodeDetailUseCase.execute(episode: episode)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
