
class LocationListRepository: LocationListRepositoryProtocol {

    private let locationListDataSource: LocationListDataSourceProtocol
    
    init(locationListDataSource: LocationListDataSourceProtocol = LocationListDataSource()) {
        self.locationListDataSource = locationListDataSource
    }

    func fetchLocations(page: Int? = nil, name: String? = nil) async throws -> LocationListResponseModel {
        let locationListResponse: LocationListResponseModel = try await locationListDataSource.fetchLocations(page: page, name: name)

        return locationListResponse
    }
}
