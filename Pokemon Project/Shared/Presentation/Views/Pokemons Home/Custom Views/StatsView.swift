//
//  StatsView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 28/3/25.
//

import SwiftUI

struct StatsView: View {
    
    var singlePokemon: PokemonSingleModelResponse
    @State private var sliderValue: Double = 0
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(singlePokemon.stats, id:\.stat.name) { pokemon in
                    HStack(spacing: 15) {
                        Text("\(pokemon.stat.name.uppercased()):")
                            .font(.headline)
                            
                         
                        Text("\(pokemon.base_stat)")
                            .font(.callout)
                        
                        Slider(value: $sliderValue, in: 0...100, step: 1)
                            .tint( pokemon.base_stat > 50 ? .green : .red)
                            .disabled(true)
                            .onAppear {
                                sliderValue = Double(pokemon.base_stat)
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
        }
    }
}

#Preview {
    StatsView(singlePokemon: PokemonSingleModelResponse( abilities: [Abilities(ability: Abilities.Ability(name: "Electric")), Abilities(ability: Abilities.Ability(name: "Water power"))], moves: [Moves(move: Moves.Move(name: "Razor-wind"))], stats: [Stats(base_stat: 45, effort: 0, stat: Stats.Stat(name: "hp"))] , sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Bulbasaur", weight: 69, height: 7))
}
