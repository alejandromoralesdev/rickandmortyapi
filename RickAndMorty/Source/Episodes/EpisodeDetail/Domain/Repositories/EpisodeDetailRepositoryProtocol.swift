//
//  EpisodeDetailRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 19/10/25.
//

import Foundation

protocol EpisodeDetailRepositoryProtocol {
    func fetchEpisode(episode: Int) async throws -> EpisodeEntity
}
