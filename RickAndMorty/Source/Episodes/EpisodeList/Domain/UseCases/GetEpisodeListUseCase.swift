import Foundation

class GetEpisodeListUseCase {
    let repository: EpisodeListRepositoryProtocol

    init(episodeRepository: EpisodeListRepositoryProtocol = EpisodeListRepository()) {
        self.repository = episodeRepository
    }

    func execute(page: Int? = nil, name: String? = nil) async throws -> EpisodeListResponseModel {
        return try await repository.fetchEpisodes(page: page, name: name)
    }
}
