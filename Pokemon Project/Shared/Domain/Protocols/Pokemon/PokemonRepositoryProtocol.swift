import Foundation

protocol PokemonRepositoryProtocol {
    func getPokemons() async throws -> [Pokemon]
}
