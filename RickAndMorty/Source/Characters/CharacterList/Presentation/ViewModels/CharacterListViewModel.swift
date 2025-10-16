import Foundation

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    @Published var isLoadingInitial: Bool = false
    @Published var isLoadingPage: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false

    private var currentPage: Int = 1 // próxima página a solicitar
    private var totalPages: Int? = nil
    private let getCharacterListUseCase: GetCharacterListUseCase

    public init(getCharacterListUseCase: GetCharacterListUseCase = GetCharacterListUseCase()) {
        self.getCharacterListUseCase = getCharacterListUseCase
    }

    // Carga inicial (primera página)
    func loadInitialCharacters() async {
        if !characters.isEmpty { return } // ya cargado
        isLoadingInitial = true
        errorMessage = nil
        currentPage = 1
        totalPages = nil
        characters.removeAll()

        await fetchPage(page: currentPage)
        isLoadingInitial = false
    }

    // Decide si debe cargar la siguiente página cuando cierta celda aparece
    func loadMoreIfNeeded(for character: CharacterEntity, prefetchOffset: Int = 3) async {
        guard !isLoadingPage else { return }
        guard let last = characters.last else { return }

        // Opción 1: disparar cuando es el último item
        if character.id == last.id {
            await loadNextPageIfNeeded()
            return
        }

        // Opción 2 (prefetch): cuando el índice del elemento es cercano al final
        if let idx = characters.firstIndex(where: { $0.id == character.id }) {
            let thresholdIndex = max(0, characters.count - 1 - prefetchOffset)
            if idx >= thresholdIndex {
                await loadNextPageIfNeeded()
            }
        }
    }

    // Comprueba condiciones y solicita la siguiente página
    private func loadNextPageIfNeeded() async {
        // Si ya sabemos totalPages y hemos alcanzado el final, no hacemos nada
        if let total = totalPages, currentPage > total {
            return
        }
        await fetchPage(page: currentPage)
    }

    // Petición de página y manejo de respuesta / errores
    private func fetchPage(page: Int) async {
        guard !isLoadingPage else { return }
        isLoadingPage = true

        do {
            let response = try await getCharacterListUseCase.execute(page: page)
            // Append resultados
            characters.append(contentsOf: response.results)
            // Guardar total de páginas (si está)
            totalPages = response.info.pages
            // Incrementar next page sólo si no hemos llegado al final
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }

        isLoadingPage = false
    }
}
