//
//  PokemonNetworkTests.swift
//  Pokemon ProjectTests
//
//  Created by Andy Heredia on 19/4/25.
//

import XCTest
@testable import Pokemon_Project

final class PokemonNetworkTests: XCTestCase {
    
    var sut: PokemonNetworkMock!
    
    override func setUpWithError() throws {
        sut = PokemonNetworkMock()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testPokemonNetwork_WithMockedResponse_ShouldReturnTwoPokemons() async throws {
        let expectedNumber = 2
        
        let pokemons = try await sut.getPokemons()
        XCTAssertEqual(pokemons.count, expectedNumber)
    }
    
    func testPokemonNetwork_GivenErrorApp_ShouldBeEqual() {
        XCTAssertEqual(ErrorApp.badUrl, ErrorApp.badUrl)
        XCTAssertEqual(ErrorApp.characterNotFound(idCharacter: 1), ErrorApp.characterNotFound(idCharacter: 1))
        XCTAssertEqual(ErrorApp.errorFromApi(statuscode: "Error"), ErrorApp.errorFromApi(statuscode: "Error"))
        XCTAssertEqual(ErrorApp.errorParsingData, ErrorApp.errorParsingData)
        XCTAssertEqual(ErrorApp.noDataReceived, ErrorApp.noDataReceived)
        XCTAssertEqual(ErrorApp.requestWasNil, ErrorApp.requestWasNil)
    }
    
    
    /// Tests that the raw values of the `Endpoints` enum match the expected endpoint strings.
    func testEndpoints_RawValues_ShouldMatchExpectedStrings() {
        XCTAssertEqual(Endpoints.characters.rawValue, "/pokemon?limit=151")
        XCTAssertEqual(Endpoints.singleCharacter.rawValue, "/pokemon")
    }
    
    /// Tests that the raw string values of the `HttpMethods` enum match the expected HTTP verbs.
    func testHttpMethods_StaticValues_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.delete, "DELETE")
        XCTAssertEqual(HttpMethods.get, "GET")
        XCTAssertEqual(HttpMethods.post, "POST")
        XCTAssertEqual(HttpMethods.put, "PUT")
    }
    
    /// Tests that the static integer constants in `HttpResponseCode` match the expected HTTP status codes.
    func testHttpResponseCode_StaticValues_ShouldBeCorrect() {
        XCTAssertEqual(HttpResponseCode.ERROR, 502)
        XCTAssertEqual(HttpResponseCode.SUCCESS, 200)
        XCTAssertEqual(HttpResponseCode.NOT_AUTHORIZED, 400)
    }
    
}
    
    
    


