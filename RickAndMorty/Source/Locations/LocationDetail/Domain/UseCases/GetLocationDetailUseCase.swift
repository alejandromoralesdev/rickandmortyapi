import Foundation

class GetLocationDetailUseCase {
    let repository: LocationDetailRepositoryProtocol

    init(locationDetailRepository: LocationDetailRepositoryProtocol = LocationDetailRepository()) {
        self.repository = locationDetailRepository
    }

    func execute(location: Int) async throws -> LocationEntity {
        return try await repository.fetchLocation(location: location)
    }
}

