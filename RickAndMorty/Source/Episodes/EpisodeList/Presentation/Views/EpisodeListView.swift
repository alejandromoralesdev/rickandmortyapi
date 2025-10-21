import SwiftUI

struct EpisodeListView: View {
    @StateObject var viewModel = EpisodeListViewModel()
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.episodes) { episode in
                    EpisodeCardView(
                        episode: episode,
                        size: min(viewModel.size.width, viewModel.size.height)
                    )
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(for: episode)
                            }
                        }
                        .onTapGesture {
                            path.append(episode)
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
            await viewModel.loadInitialEpisodes()
        }
        .refreshable {
            await viewModel.loadInitialEpisodes()
        }
        .navigationTitle(L10n.Common.episodes)
        .navigationBarTitleDisplayMode(.inline)
        .alert(L10n.Errors.alertTitle, isPresented: $viewModel.showError, actions: {
            Button(L10n.Errors.alertButton, role: .cancel) { viewModel.showError = false }
        }, message: {
            Text(viewModel.errorMessage ?? L10n.Errors.general)
        })
    }
}
