import Foundation

protocol PokemonSingleRepositoryProtocol {
    func getSinglePokemon() async throws -> [PokemonSingleModelResponse]
}
