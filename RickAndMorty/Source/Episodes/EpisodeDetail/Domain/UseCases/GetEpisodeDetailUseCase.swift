//
//  GetEpisodeDetailUseCase.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 19/10/25.
//

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
