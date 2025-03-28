import Foundation

final class PokemonUseCase: PokemonUseCaseProtocol {
    var repo: PokemonRepositoryProtocol
    
    init(repo:  PokemonRepositoryProtocol = PokemonRepository()) {
        self.repo = repo
    }
    
    func getPokemons() async throws -> [Pokemon] {
        return try await repo.getPokemons()
    }
    
    
}
