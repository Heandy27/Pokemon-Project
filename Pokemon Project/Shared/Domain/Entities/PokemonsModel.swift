import Foundation

struct PokemonsModelResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    var id: String {UUID().uuidString}
    let name: String
    let url: String
}
