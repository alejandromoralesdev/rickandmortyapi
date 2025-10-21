import SwiftUI

enum Destination: Hashable {
    case characters
    case episodes
}

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(
                    colors: [Color(.systemIndigo), Color(.systemTeal)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    VStack(spacing: 6) {
                        Text(L10n.Common.welcome)
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)
                        Text(L10n.Common.choose)
                            .font(.subheadline)
                            .foregroundColor(Color.white.opacity(0.85))
                    }.padding(.bottom, 28)
                    
                    VStack(spacing: 16) {
                        FancyButton(
                            title: L10n.Common.allCharacters,
                            subtitle: nil,
                            systemIcon: Image.InitialScreen.allCharacters,
                            gradient: LinearGradient(colors: [Color.purple, Color.pink],
                                                     startPoint: .topLeading, endPoint: .bottomTrailing)
                        ) {
                            path.append(Destination.characters)
                        }
                        
                        FancyButton(
                            title: L10n.Common.allEpisodes,
                            subtitle: nil,
                            systemIcon: Image.InitialScreen.allEpisodes,
                            gradient: LinearGradient(colors: [Color.blue, Color.teal],
                                                     startPoint: .topLeading, endPoint: .bottomTrailing)
                        ) {
                            path.append(Destination.episodes)
                        }
                    }.padding(.horizontal, 30)
                    
                    Spacer()
                }
                .padding(.vertical, 40)
            }
            .navigationDestination(for: Destination.self) { route in
                switch route {
                case .characters:
                    CharacterListView(path: $path)
                case .episodes:
                    EpisodeListView(path: $path)
                }
            }
            .navigationDestination(for: CharacterEntity.self) { character in
                CharacterDetailView(character: character)
            }
            .navigationDestination(for: EpisodeEntity.self) { episode in
                EpisodeDetailView(episodeId: episode.id, episode: episode)
            }
        }
    }
}
