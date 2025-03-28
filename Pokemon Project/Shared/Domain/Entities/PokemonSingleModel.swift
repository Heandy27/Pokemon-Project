import Foundation

struct PokemonSingleModelResponse: Codable, Identifiable {
    let abilities: [Abilities]
    let moves: [Moves]
    let stats: [Stats]
    let sprites: Sprites
    let types: [Types]
    let id: Int
    let name: String
    let weight: Int
    let height: Int
}

struct Abilities: Codable {
    let ability: Ability
    
    
    
    struct Ability: Codable {
        let name: String
    }
}

struct Sprites: Codable {
    let front_default: String
}

struct Moves: Codable {
    let move: Move
    
    struct Move: Codable {
        let name: String
    }
}

struct Stats: Codable {
    let base_stat: Int
    let effort: Int
    let stat: Stat
    
    struct Stat: Codable {
        let name: String
    }
}

struct Types: Codable {
    let type: TypeResponse
    
    
    struct TypeResponse: Codable {
        let name: String
    }
}
