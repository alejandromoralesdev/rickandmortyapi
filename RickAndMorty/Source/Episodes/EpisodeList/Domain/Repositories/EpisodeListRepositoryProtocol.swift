import Foundation

protocol EpisodeListRepositoryProtocol {
    func fetchEpisodes(page: Int?, name: String?) async throws -> EpisodeListResponseModel
}
