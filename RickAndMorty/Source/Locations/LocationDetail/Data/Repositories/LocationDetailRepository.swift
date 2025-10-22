
class LocationDetailRepository: LocationDetailRepositoryProtocol {

    private let locationDetailDataSource: LocationDetailDataSourceProtocol
    
    init(locationDetailDataSource: LocationDetailDataSourceProtocol = LocationDetailDataSource()) {
        self.locationDetailDataSource = locationDetailDataSource
    }

    func fetchLocation(location: Int) async throws -> LocationEntity {
        let locationDetailResponse: LocationEntity = try await locationDetailDataSource.fetchLocation(location: location)

        return locationDetailResponse
    }
}
