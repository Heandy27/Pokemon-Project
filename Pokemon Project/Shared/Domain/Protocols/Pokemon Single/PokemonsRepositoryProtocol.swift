import Foundation

protocol PokemonsRepositoryProtocol {
    func getPokemons() async throws -> [PokemonsModelResponse]
}
