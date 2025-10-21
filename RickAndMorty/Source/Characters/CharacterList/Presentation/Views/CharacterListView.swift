import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterListViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.characters) { character in
                        CharacterCardView(character: character)
                            .onAppear {
                                Task {
                                    await viewModel.loadMoreIfNeeded(for: character)
                                }
                            }
                            .onTapGesture {
                                path.append(character)
                            }
                    }

                    if viewModel.isLoadingPage || viewModel.isLoadingInitial {
                        ProgressView()
                            .padding()
                    }
                }
                .padding(.vertical, 8)
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .task {
                await viewModel.loadInitialCharacters()
            }
            .refreshable {
                await viewModel.loadInitialCharacters()
            }
            .navigationTitle(L10n.Common.mainTitle)
            .navigationBarTitleDisplayMode(.inline)
            .alert(L10n.Errors.alertTitle, isPresented: $viewModel.showError, actions: {
                Button(L10n.Errors.alertButton, role: .cancel) { viewModel.showError = false }
            }, message: {
                Text(viewModel.errorMessage ?? L10n.Errors.general)
            })
            .navigationDestination(for: CharacterEntity.self) { character in
                CharacterDetailView(character: character)
            }
        }
    }
}
