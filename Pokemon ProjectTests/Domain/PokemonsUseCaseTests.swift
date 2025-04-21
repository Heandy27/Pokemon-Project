//
//  PokemonsUseCaseTests.swift
//  Pokemon ProjectTests
//
//  Created by Andy Heredia on 21/4/25.
//

import XCTest
@testable import Pokemon_Project

final class PokemonsUseCaseTests: XCTestCase {
    
    var useCase: PokemonUseCase!

    override func setUpWithError() throws {
        
        useCase = PokemonUseCase(repo: PokemonRepositoryMock())
    }

    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func testDePrueba() async throws {
        let expectedNumber = 2
        let pokemon = try await useCase.getPokemons()
        XCTAssertEqual(pokemon.count, expectedNumber)
    }


}
