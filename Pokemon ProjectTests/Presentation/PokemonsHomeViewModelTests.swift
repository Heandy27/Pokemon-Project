//
//  PokemonsHomeViewModelTests.swift
//  Pokemon ProjectTests
//
//  Created by Andy Heredia on 21/4/25.
//

import XCTest
@testable import Pokemon_Project

final class PokemonsHomeViewModelTests: XCTestCase {
    
    var viewModel: PokemonsHomeViewModel!

    override func setUpWithError() throws {
        viewModel = PokemonsHomeViewModel(useCase: PokemonUseCaseMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil

    }

    func testGetPokemons_WhenSuccessfulResponse_ReturnsCorrectPokemonData() async throws {
        try await viewModel.getPokemons()
        
        XCTAssertEqual(viewModel.pokemonResult.count, 2)
        XCTAssertEqual(viewModel.pokemonResult[0].name, "Bulbasaur")
        XCTAssertEqual(viewModel.pokemonResult[0].id, 1)
        XCTAssertEqual(viewModel.pokemonResult[0].height, 7)
        XCTAssertEqual(viewModel.pokemonResult[0].weight, 69)
        XCTAssertEqual(viewModel.pokemonResult[0].abilities.count, 2)
        XCTAssertEqual(viewModel.pokemonResult[0].moves.count, 1)
        XCTAssertEqual(viewModel.pokemonResult[0].stats.count, 1)
        XCTAssertEqual(viewModel.pokemonResult[0].sprites.front_default, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        XCTAssertEqual(viewModel.pokemonResult[0].stats.count, 1)
    }
    
    func testFilteredCharacter_ShouldReturnFilteredListBasedOnSearchText()  async throws {
        try await viewModel.getPokemons()
        
        viewModel.searchText = "pik"
        
        let filtered = viewModel.filteredCharacter
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.name, "Pikachu")
    }

  
}
