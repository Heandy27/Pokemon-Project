import Foundation

protocol PokemonsNetworkProtocol {
    func getPokemons() async throws -> [Pokemon]
}

final class PokemonsNetwork: PokemonsNetworkProtocol {
    
    func getPokemons() async throws -> [Pokemon] {
        var characters = [Pokemon]()
        
        let urlString = "\(ConstantsApp.baseURL)\(Endpoints.characters.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorApp.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCode.SUCCESS else {
                throw ErrorApp.errorFromApi(statuscode: "Error in the response")
            }
            
            let result = try JSONDecoder().decode(PokemonsModelResponse.self, from: data)
            
            characters = result.results
        
            
        } catch {
            throw ErrorApp.errorParsingData
        }
        
        return characters
    }
    
  
    
}
