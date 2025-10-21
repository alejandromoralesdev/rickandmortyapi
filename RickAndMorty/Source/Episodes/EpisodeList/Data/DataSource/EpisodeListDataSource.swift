import Foundation

protocol EpisodeListDataSourceProtocol {
    func fetchEpisodes(page: Int?, name: String?) async throws -> EpisodeListResponseModel
}

class EpisodeListDataSource: EpisodeListDataSourceProtocol {
    func fetchEpisodes(page: Int? = nil, name: String? = nil) async throws -> EpisodeListResponseModel {
        guard let url: URL = Constants.Endpoints.getEpisodesURL(page: page, name: name) else {
            throw URLError(.badURL)
        }

        return try await NetworkUtils.shared.fetch(from: url)
    }
}
