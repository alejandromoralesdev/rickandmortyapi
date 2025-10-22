import Foundation

protocol LocationListDataSourceProtocol {
    func fetchLocations(page: Int?, name: String?) async throws -> LocationListResponseModel
}

class LocationListDataSource: LocationListDataSourceProtocol {
    func fetchLocations(page: Int? = nil, name: String? = nil) async throws -> LocationListResponseModel {
        guard let url: URL = Constants.Endpoints.getLocationsURL(page: page, name: name) else {
            throw URLError(.badURL)
        }

        return try await NetworkUtils.shared.fetch(from: url)
    }
}
