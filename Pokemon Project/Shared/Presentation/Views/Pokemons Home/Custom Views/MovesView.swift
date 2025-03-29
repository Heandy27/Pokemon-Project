//
//  MovesView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 28/3/25.
//

import SwiftUI

struct MovesView: View {
    
    var singlePokemon: PokemonSingleModelResponse
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(singlePokemon.moves, id: \.move.name) { move in
                    Text(singlePokemon.moves.map {$0.move.name}.joined(separator: " - "))
                        .font(.callout)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(5)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MovesView(singlePokemon: PokemonSingleModelResponse( abilities: [Abilities(ability: Abilities.Ability(name: "Electric")), Abilities(ability: Abilities.Ability(name: "Water power"))], moves: [Moves(move: Moves.Move(name: "Razor-wind"))], stats: [Stats(base_stat: 45, effort: 0, stat: Stats.Stat(name: "hp"))] , sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Bulbasaur", weight: 69, height: 7))
}
