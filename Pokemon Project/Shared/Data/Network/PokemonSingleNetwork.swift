import Foundation

protocol PokemonSingleNetworkProtocol {
    func getSiglePokemon() async throws -> [PokemonSingleModelResponse]
}

final class PokemonSingleNetwork: PokemonSingleNetworkProtocol {
    func getSiglePokemon() async throws -> [PokemonSingleModelResponse] {
        var pokemonResult: [PokemonSingleModelResponse] = []
        
        
        for id in 1...151 {
            
            let urlString = "\(ConstantsApp.baseURL)\(Endpoints.singleCharacter.rawValue)/\(id)"
            
            guard let url = URL(string: urlString) else {
                throw ErrorApp.badUrl
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = HttpMethods.get
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let res = response as? HTTPURLResponse,
                        res.statusCode == HttpResponseCode.SUCCESS else {
                    throw ErrorApp.errorFromApi(statuscode: "Status code not valid")
                }
                
                let pokemon = try JSONDecoder().decode(PokemonSingleModelResponse.self, from: data)
                
                pokemonResult.append(pokemon)
            } catch {
                throw ErrorApp.errorParsingData
            }
        }
    
        return pokemonResult
    }
}
