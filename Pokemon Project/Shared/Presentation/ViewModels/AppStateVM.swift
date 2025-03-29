import Foundation

@Observable
final class AppStateVM {
    var status: StatusModel = .loading
    @ObservationIgnored
    var useCase: PokemonsUseCaseProtocol
    
    init(useCase: PokemonsUseCaseProtocol = PokemonUseCase()) {
        self.useCase = useCase
        statusApp()
    }
    
    
    @MainActor
    func getPokemons() {
        self.status = .loading
        
        Task {
            do {
                let pokemons = try await useCase.getPokemons()
                
                
                if pokemons.isEmpty {
                    self.status = .errorApp
                } else {
                    self.status = .success
                }
            } catch {
                self.status = .errorApp
            }
        }
    }
    
    
    func statusApp() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.getPokemons()
            }
        }
    }
}

