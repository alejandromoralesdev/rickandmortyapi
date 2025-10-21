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
    
    enum Endpoints {
        static let characterList = "character"
        static let characterDetail = "character/"
        static let episodeDetail = "episode/"
        
        /// Metodo que devuelve la URL para obtener la foto del personaje
        /// - Parameter id: id del personaje
        /// - Returns: la url de la foto
        static func getImageURL(id: String) -> URL? {
            let components = URLComponents(string: rickMortyApiImageBaseUrl + id + extensionImageBaseUrl)
            return components?.url
        }
        
        /// Metodo para obtener todos los personajes
        /// - Parameters:
        ///   - page: pagina que queremos obtener
        ///   - name: nombre del personaje que queremos obtener
        /// - Returns: la url para consultar los personajes
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
        
        /// Metodo para consultar el detalle de un personaje
        /// - Parameter id: id del personaje
        /// - Returns: detalle del personaje
        static func getCharacterURL(id: Int) -> URL? {
            let components = URLComponents(string: rickMortyApiBaseUrl + characterDetail + String(id))
            return components?.url
        }
        
        /// Metodo para consultar el detalle de un episodio
        /// - Parameter id: id del episodio
        /// - Returns: detalle del episodio
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
