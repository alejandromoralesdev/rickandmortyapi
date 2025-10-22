import Foundation

protocol LocationListRepositoryProtocol {
    func fetchLocations(page: Int?, name: String?) async throws -> LocationListResponseModel
}
