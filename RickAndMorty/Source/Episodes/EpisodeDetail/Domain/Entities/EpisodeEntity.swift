struct EpisodeEntity: Identifiable, Codable, Hashable {
    let id: Int
    let name: String?
    let airDate: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
    
    public init(
        id: Int = 0,
        name: String = "",
        airDate: String = "",
        episode: String = "",
        characters: [String] = [],
        url: String = "",
        created: String = ""
    ) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }
}
