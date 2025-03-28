import Foundation

protocol PokemonUseCaseProtocol {
    var repo: PokemonRepositoryProtocol { get set }
    func getPokemons() async throws -> [Pokemon]
}
