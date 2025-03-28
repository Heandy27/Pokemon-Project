import Foundation

final class PokemonSingleUseCase: PokemonSingleUseCaseProtocol {
    var repo: PokemonSingleRepositoryProtocol
    
    init(repo: PokemonSingleRepositoryProtocol = PokemonSingleRepository()) {
        self.repo = repo
    }
    
    func getSinglePokemon() async throws -> [PokemonSingleModelResponse] {
        return try await repo.getSinglePokemon()
    }
    
    
}
