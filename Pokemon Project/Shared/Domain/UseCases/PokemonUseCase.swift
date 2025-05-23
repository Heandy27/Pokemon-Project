import Foundation

final class PokemonUseCase: PokemonsUseCaseProtocol {
    var repo: PokemonsRepositoryProtocol
    
    init(repo: PokemonsRepositoryProtocol = PokemonRepository()) {
        self.repo = repo
    }
    
    func getPokemons() async throws -> [PokemonsModelResponse] {
        return try await repo.getPokemons()
    }
    
    
}


// MARK: MOCK

final class PokemonUseCaseMock: PokemonsUseCaseProtocol {
    var repo: PokemonsRepositoryProtocol
    
    init(repo: PokemonsRepositoryProtocol = PokemonRepositoryMock()) {
        self.repo = repo
    }
    
    func getPokemons() async throws -> [PokemonsModelResponse] {
        return try await repo.getPokemons()
    }
}
