import Foundation

@MainActor
class LocationDetailViewModel: ObservableObject {
    @Published var location: LocationEntity?
    @Published var isLoadingPage: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    @Published var locationId: Int?

    private let getLocationDetailUseCase: GetLocationDetailUseCase

    public init(
        locationId: Int? = nil,
        location: LocationEntity? = nil,
        getLocationDetailUseCase: GetLocationDetailUseCase = GetLocationDetailUseCase()
    ) {
        self.location = location
        self.locationId = locationId
        self.getLocationDetailUseCase = getLocationDetailUseCase
    }

    func loadLocation() async {
        if location != nil { return }
        guard let locationId else { return }
        isLoadingPage = true
        errorMessage = nil

        await fetchLocation(location: locationId)
        isLoadingPage = false
    }
    
    func getCharacterId(_ characterUrl: String) -> String {
        var chString = ""
        
        if let url = URL(string: characterUrl), !url.lastPathComponent.isEmpty {
            chString = url.lastPathComponent
        }
        
        return chString
    }

    private func fetchLocation(location: Int) async {
        do {
            self.location = try await getLocationDetailUseCase.execute(location: location)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
