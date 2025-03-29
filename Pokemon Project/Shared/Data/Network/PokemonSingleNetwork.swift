import Foundation

protocol PokemonSingleNetworkProtocol {
    func getSiglePokemon() async throws -> [PokemonSingleModelResponse]
}

final class PokemonSingleNetwork: PokemonSingleNetworkProtocol {
    func getSiglePokemon() async throws -> [PokemonSingleModelResponse] {
        await withTaskGroup(of: PokemonSingleModelResponse?.self) { group in
            var pokemonResult: [PokemonSingleModelResponse] = []

            for id in 1...151 {
                group.addTask {
                    return await self.fetchPokemon(id: id)
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
    
    private func fetchPokemon(id: Int) async -> PokemonSingleModelResponse? {
        let urlString = "\(ConstantsApp.baseURL)\(Endpoints.singleCharacter.rawValue)/\(id)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCode.SUCCESS else {
                return nil
            }
            
            return try JSONDecoder().decode(PokemonSingleModelResponse.self, from: data)
        } catch {
            return nil
        }
    }
    
}
