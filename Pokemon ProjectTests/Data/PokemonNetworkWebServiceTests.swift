//
//  PokemonNetworkWebServiceTests.swift
//  Pokemon ProjectTests
//
//  Created by Andy Heredia on 19/4/25.
//

import XCTest
@testable import Pokemon_Project

final class PokemonNetworkWebServiceTests: XCTestCase {
    
    var sut: PokemonNetwork!
    
    override func setUpWithError() throws {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(
            configuration: config
        )
        
        sut = PokemonNetwork(session: urlSession)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        MockURLProtocol.statusCode = 200
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    // Test case: Response status code is not 200 (e.g., 500).
    func testNetworkWebServices_WhenGivenSuccessfullResponse_ReturnSuccess() async throws {
        
        let data = try MockData.loadJSONData(name: "PokemonMock")
        MockURLProtocol.stubResponseData = data
        // When
        do {
            let pokemon = try await sut.getPokemons()
            // Then
            XCTAssertEqual(pokemon[0].name, "bulbasaur")
            XCTAssertEqual(pokemon[0].id, 1)
            XCTAssertEqual(pokemon[0].height, 7)
            XCTAssertEqual(pokemon[0].weight, 69)
            XCTAssertEqual(pokemon[0].abilities.count, 2)
            XCTAssertEqual(pokemon[0].moves.count, 2)
            XCTAssertEqual(pokemon[0].stats.count, 2)
            XCTAssertEqual(pokemon[0].sprites.front_default, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
            XCTAssertEqual(pokemon[0].stats.count, 2)
            
        } catch {
            XCTFail("Expected success, but got error \(error)")
        }
    }
    
    // Test case: Parsing failure with invalid data.
    func testFetchPokemon_WhenParsingFails_ShouldThrowErrorParsingData() async throws {
        let InvalidJson = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        let data = InvalidJson.data(using: .utf8)
        MockURLProtocol.stubResponseData = data
        
        do {
           _ = try await sut.fetchPokemon(id: 1)
            XCTFail("Expected to throw errorParsingData, but it did not.")
        } catch let error as ErrorApp {
            XCTAssertEqual(error, .errorParsingData)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
        
    }
    
    // Test case: Response status code is not 200 (e.g., 500).
    func testFetchPokemon_WhenStatusCodeIsNot200_ShouldThrowErrorFromApi() async throws {
        let json = "{}"
        let data = json.data(using: .utf8)
        MockURLProtocol.stubResponseData = data
        MockURLProtocol.statusCode = 500
        
        do {
            _ = try await sut.fetchPokemon(id: 1)
            XCTFail("Expected to throw errorFromApi, but it did not.")
        } catch let error as ErrorApp {
            XCTAssertEqual(error, .errorFromApi(statuscode: "500"))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // Test case: An unexpected error occurs during the request.
    func testFetchPokemon_WhenUnexpectedErrorOccurs_ShouldThrowErrorFromServer() async throws {
        let json = "{}" // Respuesta válida pero no contiene datos correctos
        let data = json.data(using: .utf8)
        MockURLProtocol.stubResponseData = data
        MockURLProtocol.statusCode = 500 // O cualquier código de estado no esperado
        
        // Simulamos un error genérico inesperado
        let expectedError = NSError(domain: "TestDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Test error"])

        // Simulamos un error inesperado al hacer la solicitud
        MockURLProtocol.error = expectedError
        
        do {
            _ = try await sut.fetchPokemon(id: 1)
            XCTFail("Expected to throw errorFromServer, but it did not.")
        } catch let error as ErrorApp {
            switch error {
            case .errorFromServer(let wrappedError):
                // Aquí verificamos que el error envuelto sea el esperado
                if let nsError = wrappedError as? NSError {
                    XCTAssertEqual(nsError.domain, "TestDomain")
                    XCTAssertEqual(nsError.code, 123)
                    XCTAssertEqual(nsError.localizedDescription, "Test error")
                } else {
                    XCTFail("Expected wrapped error to be NSError, but it was not.")
                }
            default:
                XCTFail("Expected errorFromServer, but got \(error).")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    
}
