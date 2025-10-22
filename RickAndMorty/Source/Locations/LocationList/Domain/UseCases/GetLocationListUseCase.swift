import Foundation

class GetLocationListUseCase {
    let repository: LocationListRepositoryProtocol

    init(locationRepository: LocationListRepositoryProtocol = LocationListRepository()) {
        self.repository = locationRepository
    }

    func execute(page: Int? = nil, name: String? = nil) async throws -> LocationListResponseModel {
        return try await repository.fetchLocations(page: page, name: name)
    }
}
