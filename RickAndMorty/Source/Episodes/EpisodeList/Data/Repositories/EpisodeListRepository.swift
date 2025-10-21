

class EpisodeListRepository: EpisodeListRepositoryProtocol {

    private let episodeListDataSource: EpisodeListDataSourceProtocol
    
    init(episodeListDataSource: EpisodeListDataSourceProtocol = EpisodeListDataSource()) {
        self.episodeListDataSource = episodeListDataSource
    }

    func fetchEpisodes(page: Int? = nil, name: String? = nil) async throws -> EpisodeListResponseModel {
        let episodeListResponse: EpisodeListResponseModel = try await episodeListDataSource.fetchEpisodes(page: page, name: name)

        return episodeListResponse
    }
}
