import Foundation

protocol PokemonNetworkProtocol {
    func getPokemons() async throws -> [PokemonsModelResponse]
}

final class PokemonNetwork: PokemonNetworkProtocol {
    
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getPokemons() async throws -> [PokemonsModelResponse] {
        await withTaskGroup(of: PokemonsModelResponse?.self) { group in
            var pokemonResult: [PokemonsModelResponse] = []

            for id in 1...151 {
                group.addTask {
                    return try? await self.fetchPokemon(id: id)
                }
            }

            for await pokemon in group {
                if let pokemon = pokemon {
                    pokemonResult.append(pokemon)
                }
            }

            return pokemonResult
        }
    }
    
     func fetchPokemon(id: Int) async throws -> PokemonsModelResponse {
        let urlString = "\(ConstantsApp.baseURL)\(Endpoints.singleCharacter.rawValue)/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorApp.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await session.data(for: request)

            guard let res = response as? HTTPURLResponse else {
                throw ErrorApp.noDataReceived
            }

            guard res.statusCode == 200 else {
                throw ErrorApp.errorFromApi(statuscode: "\(res.statusCode)")
            }

            return try JSONDecoder().decode(PokemonsModelResponse.self, from: data)
        } catch is DecodingError {
            throw ErrorApp.errorParsingData
        } catch let error as ErrorApp {
            throw error // <-- Si ya es ErrorApp, lo relanzamos sin envolverlo
        } catch {
            throw ErrorApp.errorFromServer(error: error)
        }
    }
}


// MARK: Mock

final class PokemonNetworkMock: PokemonNetworkProtocol {

    func getPokemons() async throws -> [PokemonsModelResponse] {
        
        let model1 = PokemonsModelResponse( abilities: [Abilities(ability: Abilities.Ability(name: "Electric")), Abilities(ability: Abilities.Ability(name: "Water power"))], moves: [Moves(move: Moves.Move(name: "Razor-wind"))], stats: [Stats(base_stat: 45, effort: 0, stat: Stats.Stat(name: "hp"))] , sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Bulbasaur", weight: 69, height: 7)
        
        let model2 = PokemonsModelResponse( abilities: [Abilities(ability: Abilities.Ability(name: "Electric")), Abilities(ability: Abilities.Ability(name: "Water power"))], moves: [Moves(move: Moves.Move(name: "Razor-wind"))], stats: [Stats(base_stat: 45, effort: 0, stat: Stats.Stat(name: "hp"))] , sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Pikachu", weight: 69, height: 7)
        
        return [model1, model2]
    }
}
