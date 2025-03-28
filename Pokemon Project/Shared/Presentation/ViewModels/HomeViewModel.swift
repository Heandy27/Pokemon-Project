import Foundation

@Observable
final class HomeViewModel {
    
    var pokemons: [Pokemon] = []
    @ObservationIgnored
    let pokemonUseCase: PokemonUseCaseProtocol
    
    init(pokemonUseCase: PokemonUseCaseProtocol = PokemonUseCase()) {
        self.pokemonUseCase = pokemonUseCase
        
        Task {
            try await getPokemons()
        }
    }
    
    @MainActor
    func getPokemons() async throws {
        let data = try await pokemonUseCase.getPokemons()
        pokemons = data
    }
    
}
