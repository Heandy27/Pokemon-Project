import Foundation

final class PokemonRepository: PokemonRepositoryProtocol {
    
    var network: PokemonsNetworkProtocol
    
    init(network: PokemonsNetworkProtocol = PokemonsNetwork()) {
        self.network = network
    }
    
    func getPokemons() async throws -> [Pokemon] {
        return try await network.getPokemons()
    }
    
}
