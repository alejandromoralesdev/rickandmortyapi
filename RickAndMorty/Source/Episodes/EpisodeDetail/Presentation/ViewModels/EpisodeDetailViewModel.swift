import Foundation

@MainActor
class EpisodeDetailViewModel: ObservableObject {
    @Published var episode: EpisodeEntity = EpisodeEntity()
    @Published var isLoadingInitial: Bool = false
    @Published var isLoadingPage: Bool = false
//    @Published var navigateToDetail: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    @Published var episodeId: Int

    private let getEpisodeDetailUseCase: GetEpisodeDetailUseCase

    public init(episodeId: Int, getEpisodeDetailUseCase: GetEpisodeDetailUseCase = GetEpisodeDetailUseCase()) {
        self.episodeId = episodeId
        self.getEpisodeDetailUseCase = getEpisodeDetailUseCase
    }

    // Carga inicial (primera página)
    func loadEpisode() async {
        isLoadingInitial = true
        errorMessage = nil

        await fetchEpisode(episode: episodeId)
        isLoadingInitial = false
    }
    
    func getCharacterId(_ characterUrl: String) -> String {
        var chString = ""
        
        if let url = URL(string: characterUrl), !url.lastPathComponent.isEmpty {
            chString = url.lastPathComponent
        }
        
        return chString
    }

    // Petición de página y manejo de respuesta / errores
    private func fetchEpisode(episode: Int) async {
        guard !isLoadingPage else { return }
        isLoadingPage = true

        do {
            self.episode = try await getEpisodeDetailUseCase.execute(episode: episode)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }

        isLoadingPage = false
    }
}
