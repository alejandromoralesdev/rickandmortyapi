//
//  Constants.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 16/10/25.
//
import Foundation

enum Constants {
    static let rickMortyApiBaseUrl: String = "https://rickandmortyapi.com/api/"
    static let rickMortyApiImageBaseUrl: String = "https://rickandmortyapi.com/api/character/avatar/"
    static let extensionImageBaseUrl: String = ".jpeg"
    static let rickMortyApiTimeoutInterval: Double = 15.0
    static let loading = "Cargando..."
    
    enum Endpoints {
        static let characterList = "character"
        static let episodeDetail = "episode/"
        
        static func getImageURL(id: String) -> URL? {
            let components = URLComponents(string: rickMortyApiImageBaseUrl + id + extensionImageBaseUrl)
            return components?.url
        }
        
        static func getCharactersURL(page: Int? = nil, name: String? = nil) -> URL? {
            var components = URLComponents(string: rickMortyApiBaseUrl + characterList)
            var queryItems: [URLQueryItem] = []
            
            if let page = page {
                queryItems.append(URLQueryItem(name: QueryItems.page, value: String(page)))
            }
            
            if let name = name {
                queryItems.append(URLQueryItem(name: QueryItems.name, value: name))
            }
            
            components?.queryItems = queryItems.isEmpty ? nil : queryItems
            
            return components?.url
        }
        
        static func getEpisodeURL(id: Int) -> URL? {
            let components = URLComponents(string: rickMortyApiBaseUrl + episodeDetail + String(id))
            return components?.url
        }
    }
    
    enum QueryItems {
        static let page = "page"
        static let name = "name"
    }
    
    enum Character {
        static let statusAlive = "alive"
        static let statusDead = "dead"
    }
    
    enum Sizes {
        static let imageSize: CGFloat = 160
        static let cardCharactersSize: CGFloat = 140
        static let cardEpisodesSize: CGFloat = 80
        static let cornerRadius: CGFloat = 12
        static let episodesSpacing: CGFloat = 12
        static let rowHeight: CGFloat = 140
        static let imageWidth: CGFloat = 120
    }
}
