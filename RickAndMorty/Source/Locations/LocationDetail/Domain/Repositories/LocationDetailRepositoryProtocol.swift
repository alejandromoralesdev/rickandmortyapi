import Foundation

protocol LocationDetailRepositoryProtocol {
    func fetchLocation(location: Int) async throws -> LocationEntity
}
