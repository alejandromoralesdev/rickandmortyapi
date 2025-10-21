import SwiftUI

enum Destination: Hashable {
    case characters
    case episodes
}

// 2) ContentView raíz con NavigationStack y NavigationPath compartido
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
            // 3) Destinos para el enum y para CharacterEntity (si se va a appendear)
            .navigationDestination(for: Destination.self) { route in
                switch route {
                case .characters:
                    // Pasamos el binding del path para que la lista pueda appendear detalles
                    CharacterListView(path: $path)
                case .episodes:
                    EpisodeListView(path: $path)
                }
            }
            // 4) Si vas a appendear CharacterEntity directamente, registra su destino aquí
            .navigationDestination(for: CharacterEntity.self) { character in
                CharacterDetailView(character: character)
            }
            .navigationDestination(for: EpisodeEntity.self) { episode in
                EpisodeDetailView(episodeId: episode.id, episode: episode)
            }
        }
    }
}
