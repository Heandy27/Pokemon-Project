//
//  PokemonSingleView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 27/3/25.
//

import SwiftUI

struct PokemonSingleView: View {
    
    var singlePokemon: PokemonSingleModelResponse
    @State var viewModel = PokemonsViewModel()
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .center) {
                Text(singlePokemon.name.capitalized)
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack {
                    VStack {
                        Text("Information:")
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
        
    }
}

#Preview {
    PokemonSingleView(singlePokemon: PokemonSingleModelResponse(abilities: [], moves: [], stats: [], sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Bulbasaur", weight: 69, height: 7))
}
