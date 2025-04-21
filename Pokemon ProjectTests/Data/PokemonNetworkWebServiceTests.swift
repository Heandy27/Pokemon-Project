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
        
        sut = PokemonNetwork(
            session: urlSession
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        MockURLProtocol.statusCode = 200
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
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
}
