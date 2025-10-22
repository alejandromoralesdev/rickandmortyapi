import Foundation

@MainActor
class LocationListViewModel: ObservableObject {
    @Published var locations: [LocationEntity] = []
    @Published var isLoadingInitial: Bool = false
    @Published var isLoadingPage: Bool = false
    @Published var navigateToDetail: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    let size = CGSize(width: Constants.Sizes.cardEpisodesListSize, height: Constants.Sizes.cardEpisodesListSize)

    private var currentPage: Int = 1
    private var totalPages: Int? = nil
    private let getLocationListUseCase: GetLocationListUseCase

    public init(getLocationListUseCase: GetLocationListUseCase = GetLocationListUseCase()) {
        self.getLocationListUseCase = getLocationListUseCase
    }

    func loadInitialLocations() async {
        if !locations.isEmpty { return }
        isLoadingInitial = true
        errorMessage = nil
        currentPage = 1
        totalPages = nil
        locations.removeAll()

        await fetchPage(page: currentPage)
        isLoadingInitial = false
    }

    func loadMoreIfNeeded(for character: LocationEntity, prefetchOffset: Int = 3) async {
        guard !isLoadingPage else { return }

        if let idx = locations.firstIndex(where: { $0.id == character.id }) {
            let thresholdIndex = max(0, locations.count - 1 - prefetchOffset)
            if idx >= thresholdIndex {
                await loadNextPageIfNeeded()
            }
        }
    }

    private func loadNextPageIfNeeded() async {
        if let total = totalPages, currentPage > total {
            return
        }
        await fetchPage(page: currentPage)
    }

    private func fetchPage(page: Int) async {
        guard !isLoadingPage else { return }
        isLoadingPage = true

        do {
            let response = try await getLocationListUseCase.execute(page: page)
            
            locations.append(contentsOf: response.results)

            totalPages = response.info.pages

            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }

        isLoadingPage = false
    }
}
