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
    
    func getTypeColor(type: String) -> LinearGradient {
        switch type {
        case "fire":return LinearGradient(gradient: Gradient(colors: [.red, .red.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottomTrailing)
        case "poison":return LinearGradient(gradient: Gradient(colors: [.green, .green.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "water":return LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "electric":return LinearGradient(gradient: Gradient(colors: [.yellow, .yellow.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "psychic":return LinearGradient(gradient: Gradient(colors: [.purple, .purple.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "normal":return LinearGradient(gradient: Gradient(colors: [.orange, .orange.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "ground":return LinearGradient(gradient: Gradient(colors: [.gray, .gray.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "flying":return LinearGradient(gradient: Gradient(colors: [.teal, .teal.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "fairy":return LinearGradient(gradient: Gradient(colors: [.pink, .pink.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        case "grass": return LinearGradient(gradient: Gradient(colors: [.green, .green.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
            
        default:
            return LinearGradient(gradient: Gradient(colors: [.indigo, .indigo.opacity(0.5)]), startPoint: UnitPoint(x: 0.5, y: 0.2), endPoint: .bottom)
        }
    }
    
}
