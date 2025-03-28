import Foundation

protocol PokemonSingleUseCaseProtocol {
    var repo: PokemonSingleRepositoryProtocol { get set }
    func getSinglePokemon() async throws -> [PokemonSingleModelResponse]
}
