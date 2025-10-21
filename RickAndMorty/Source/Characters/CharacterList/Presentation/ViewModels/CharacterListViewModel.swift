import Foundation

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    @Published var isLoadingInitial: Bool = false
    @Published var isLoadingPage: Bool = false
    @Published var navigateToDetail: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false

    private var currentPage: Int = 1
    private var totalPages: Int? = nil
    private let getCharacterListUseCase: GetCharacterListUseCase

    public init(getCharacterListUseCase: GetCharacterListUseCase = GetCharacterListUseCase()) {
        self.getCharacterListUseCase = getCharacterListUseCase
    }

    func loadInitialCharacters() async {
        if !characters.isEmpty { return }
        isLoadingInitial = true
        errorMessage = nil
        currentPage = 1
        totalPages = nil
        characters.removeAll()

        await fetchPage(page: currentPage)
        isLoadingInitial = false
    }

    func loadMoreIfNeeded(for character: CharacterEntity, prefetchOffset: Int = 3) async {
        guard !isLoadingPage else { return }

        if let idx = characters.firstIndex(where: { $0.id == character.id }) {
            let thresholdIndex = max(0, characters.count - 1 - prefetchOffset)
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
            let response = try await getCharacterListUseCase.execute(page: page)
            
            characters.append(contentsOf: response.results)

            totalPages = response.info.pages

            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }

        isLoadingPage = false
    }
}
