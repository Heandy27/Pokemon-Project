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

// MARK: MOCK

final class PokemonRepositoryMock: PokemonsRepositoryProtocol {
   
    var network: PokemonNetworkProtocol
    
    init(network: PokemonNetworkProtocol = PokemonNetworkMock()) {
        self.network = network
    }
    
    func getPokemons() async throws -> [PokemonsModelResponse] {
        return try await network.getPokemons()
    }
    
}
