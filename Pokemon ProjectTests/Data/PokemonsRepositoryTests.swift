//
//  PokemonsRepositoryTests.swift
//  Pokemon ProjectTests
//
//  Created by Andy Heredia on 21/4/25.
//

import XCTest
@testable import Pokemon_Project

final class PokemonsRepositoryTests: XCTestCase {
    
    var repository: PokemonRepository!

    override func setUpWithError() throws {
        repository = PokemonRepository(network: PokemonNetworkMock())
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    func testRepository_WhenFetchedPokemons_ReturnsCorrectCount() async throws {
        let expectedNumberOfPokemons = 2
        
        let pokemon = try await repository.getPokemons()
        
        XCTAssertEqual(pokemon.count, expectedNumberOfPokemons)
    }

}
