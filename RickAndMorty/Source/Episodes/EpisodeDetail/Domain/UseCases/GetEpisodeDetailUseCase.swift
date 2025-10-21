import Foundation

class GetEpisodeDetailUseCase {
    let repository: EpisodeDetailRepositoryProtocol

    init(episodeDetailRepository: EpisodeDetailRepositoryProtocol = EpisodeDetailRepository()) {
        self.repository = episodeDetailRepository
    }

    func execute(episode: Int) async throws -> EpisodeEntity {
        return try await repository.fetchEpisode(episode: episode)
    }
}
