import Foundation

protocol LocationDetailDataSourceProtocol {
    func fetchLocation(location: Int) async throws -> LocationEntity
}

class LocationDetailDataSource: LocationDetailDataSourceProtocol {
    func fetchLocation(location: Int) async throws -> LocationEntity {
        guard let url: URL = Constants.Endpoints.getLocationURL(id: location) else {
            throw URLError(.badURL)
        }

        return try await NetworkUtils.shared.fetch(from: url)
    }
}
