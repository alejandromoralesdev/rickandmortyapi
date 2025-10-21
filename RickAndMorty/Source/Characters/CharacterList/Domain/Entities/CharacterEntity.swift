
struct CharacterEntity: Identifiable, Codable, Hashable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: LocationCharacterEntity?
    let location: LocationCharacterEntity?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}
