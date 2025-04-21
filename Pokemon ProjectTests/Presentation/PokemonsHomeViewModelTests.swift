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

    func testExample() async throws {
        try await viewModel.getPokemons()
        
        XCTAssertEqual(viewModel.pokemonResult.count, 2)
        XCTAssertEqual(viewModel.pokemonResult[0].name, "Bulbasaur")
    }
    
    func testFilteredCharacter_ShouldReturnFilteredListBasedOnSearchText()  async throws {
        try await viewModel.getPokemons()
        
        viewModel.searchText = "pik"
        
        let filtered = viewModel.filteredCharacter
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.name, "Pikachu")
    }

  
}
