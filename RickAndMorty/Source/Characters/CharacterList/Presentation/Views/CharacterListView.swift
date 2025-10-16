import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoadingInitial {
                    ProgressView("Cargando personajes...")
                        .padding()
                }

                List {
                    ForEach(viewModel.characters) { character in
                        HStack {
                            AsyncImage(url: URL(string: character.image ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else if phase.error != nil {
                                    // imagen de error
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                } else {
                                    // placeholder
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }

                            Text(character.name ?? "")
                                .font(.headline)
                        }
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(for: character)
                            }
                        }
                    }

                    // Footer de carga
                    if viewModel.isLoadingPage {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .task {
                    await viewModel.loadInitialCharacters()
                }
                .refreshable {
                    // Opcional: permitir refresh pull-to-refresh
                    await viewModel.loadInitialCharacters()
                }
                .alert("Error", isPresented: $viewModel.showError, actions: {
                    Button("OK", role: .cancel) { viewModel.showError = false }
                }, message: {
                    Text(viewModel.errorMessage ?? "Ocurrió un error")
                })
            }
            .navigationTitle("Personajes de Rick & Morty")
        }
    }
}
