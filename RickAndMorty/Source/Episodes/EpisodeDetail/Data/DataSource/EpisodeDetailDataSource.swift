import Foundation

protocol EpisodeDetailDataSourceProtocol {
    func fetchEpisode(episode: Int) async throws -> EpisodeEntity
}

class EpisodeDetailDataSource: EpisodeDetailDataSourceProtocol {
    func fetchEpisode(episode: Int) async throws -> EpisodeEntity {
        guard let url: URL = Constants.Endpoints.getEpisodeURL(id: episode) else {
            throw URLError(.badURL)
        }

        return try await NetworkUtils.shared.fetch(from: url)
    }
}
