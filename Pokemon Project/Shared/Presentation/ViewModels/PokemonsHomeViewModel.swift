import Foundation
import SwiftUICore
import UIKit

@Observable
final class PokemonsHomeViewModel {
    var pokemonResult: [PokemonsModelResponse] = []
    var searchText: String = ""
    
    @ObservationIgnored
    let useCase: PokemonsUseCaseProtocol
    
    init(useCase: PokemonsUseCaseProtocol = PokemonUseCase()) {
        self.useCase = useCase
        
        Task {
            try await getPokemons()
        }
    }
    
    @MainActor
    func getPokemons() async throws {
        let data = try await useCase.getPokemons()
        pokemonResult = data
    }

    
    var filteredCharacter: [PokemonsModelResponse] {
        if searchText.isEmpty {
            return pokemonResult
        } else {
            return pokemonResult.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func getTypeColor(type: String) -> Color {
        switch type {
        case "fire":return .red
        case "poison":return .green
        case "water":return .blue
        case "electric":return .yellow
        case "psychic":return .purple
        case "normal":return .orange
        case "ground":return .gray
        case "flying":return .teal
        case "fairy":return .pink
        case "grass": return .green
            
        default:
            return .indigo
        }
    }
    
}
