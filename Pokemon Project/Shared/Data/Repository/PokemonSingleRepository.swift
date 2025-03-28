import Foundation

final class PokemonSingleRepository: PokemonSingleRepositoryProtocol {
    
    
    var network: PokemonSingleNetworkProtocol
    
    init(network: PokemonSingleNetworkProtocol = PokemonSingleNetwork()) {
        self.network = network
    }
    
    func getSinglePokemon() async throws -> [PokemonSingleModelResponse] {
        try await network.getSiglePokemon()
    }
    
}
