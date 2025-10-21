
class EpisodeDetailRepository: EpisodeDetailRepositoryProtocol {

    private let episodeDetailDataSource: EpisodeDetailDataSourceProtocol
    
    init(episodeDetailDataSource: EpisodeDetailDataSourceProtocol = EpisodeDetailDataSource()) {
        self.episodeDetailDataSource = episodeDetailDataSource
    }

    func fetchEpisode(episode: Int) async throws -> EpisodeEntity {
        let episodeDetailResponse: EpisodeEntity = try await episodeDetailDataSource.fetchEpisode(episode: episode)

        return episodeDetailResponse
    }
}
