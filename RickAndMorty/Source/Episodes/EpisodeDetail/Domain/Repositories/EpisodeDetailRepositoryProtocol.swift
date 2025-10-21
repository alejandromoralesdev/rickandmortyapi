import Foundation

protocol EpisodeDetailRepositoryProtocol {
    func fetchEpisode(episode: Int) async throws -> EpisodeEntity
}
