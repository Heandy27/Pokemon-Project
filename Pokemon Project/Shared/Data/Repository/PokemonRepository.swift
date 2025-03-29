import Foundation

final class PokemonRepository: PokemonsRepositoryProtocol {
    
    
    var network: PokemonNetworkProtocol
    
    init(network: PokemonNetworkProtocol = PokemonNetwork()) {
        self.network = network
    }
    
    func getPokemons() async throws -> [PokemonsModelResponse] {
        try await network.getPokemons()
    }
    
}
