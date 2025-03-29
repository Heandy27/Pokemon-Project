//
//  PokemonSingleView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 27/3/25.
//

import SwiftUI

struct PokemonCellGridView: View {
    
    var singlePokemon: PokemonsModelResponse
    @State var viewModel = PokemonsHomeViewModel()
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .center) {
                Text(singlePokemon.name.capitalized)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack {
                    VStack {
                        Text("Type:  \(singlePokemon.types[0].type.name.capitalized)")
                            .font(.system(size: 12))
                            .font(.subheadline).bold()
                            .foregroundStyle(.white)
                            
                        Text("Weight: \(singlePokemon.weight)")
                            .font(.system(size: 12))
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        Text("Height: \(singlePokemon.height)")
                            .font(.system(size: 12))
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 90)
                    .padding(.vertical)
                    .background(.secondary)
                    .clipShape(.rect(cornerRadius: 10))
                    AsyncImage(url: URL(string: singlePokemon.sprites.front_default)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 90)
                        
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 90)
                    }
                }
            }
            .frame(width: 160, height: 150)
            .padding()
            
            .background(viewModel.getTypeColor(type: singlePokemon.types.first?.type.name ?? ""))
            .clipShape(.rect(cornerRadius: 10))
            
          
        }
        .shadow(radius: 5)
    }
}



#Preview {
    PokemonCellGridView(singlePokemon: PokemonsModelResponse( abilities: [Abilities(ability: Abilities.Ability(name: "Electric")), Abilities(ability: Abilities.Ability(name: "Water power"))], moves: [Moves(move: Moves.Move(name: "Razor-wind"))], stats: [Stats(base_stat: 45, effort: 0, stat: Stats.Stat(name: "hp"))] , sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Bulbasaur", weight: 69, height: 7))
}
