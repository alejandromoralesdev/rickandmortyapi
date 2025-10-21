
struct CharacterListResponseModel: Codable {
    let info: Info
    let results: [CharacterEntity]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
