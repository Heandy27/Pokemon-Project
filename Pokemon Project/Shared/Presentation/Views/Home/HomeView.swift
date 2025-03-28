//
//  ContentView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 18/3/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel: HomeViewModel
    
    var body: some View {
      
        NavigationStack {
            List {
                ForEach(viewModel.pokemons) { pokemon in
                    Text(pokemon.name.capitalized)
                }
                
            }
            .navigationTitle("Characters")
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
