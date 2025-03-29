import Foundation

protocol PokemonsUseCaseProtocol {
    var repo: PokemonsRepositoryProtocol { get set }
    func getPokemons() async throws -> [PokemonsModelResponse]
}
