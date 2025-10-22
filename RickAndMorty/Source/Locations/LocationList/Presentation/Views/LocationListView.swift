import SwiftUI

struct LocationListView: View {
    @StateObject var viewModel = LocationListViewModel()
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.locations) { location in
                    LocationCardView(
                        location: location,
                        size: min(viewModel.size.width, viewModel.size.height)
                    )
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(for: location)
                            }
                        }
                        .onTapGesture {
                            path.append(location)
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
            await viewModel.loadInitialLocations()
        }
        .refreshable {
            await viewModel.loadInitialLocations()
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
