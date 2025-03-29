//
//  PokemonsView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 27/3/25.
//

import SwiftUI

struct PokemonsView: View {
    
    @State var viewModel = PokemonsViewModel()
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.filteredCharacter) { pokemon in
                        NavigationLink {
                       
                                DetailPokemon(singlePokemon: pokemon)
                             
                        } label: {
                            PokemonSingleView(singlePokemon: pokemon)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
            }
            
            .searchable(text: $viewModel.searchText, prompt: "Search your pokemon")
            .padding(.horizontal, 4)
            .navigationTitle("Pokemons")
            .ignoresSafeArea(edges: .bottom)
            
        }
    }
}


#Preview {
    PokemonsView(viewModel: PokemonsViewModel())
}
