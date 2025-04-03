//
//  DetailPokemonCell.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 28/3/25.
//

import SwiftUI

struct DetailPokemonView: View {
    
    @State var viewModel = PokemonsHomeViewModel()
    var singlePokemon: PokemonsModelResponse
    @State private var selectedTab: StatusDetail = .stats
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(viewModel.getTypeColor(type: singlePokemon.types.first?.type.name ?? "")).ignoresSafeArea()
                        
                VStack(spacing: 0) {
                    Text(singlePokemon.name.capitalized)
                        .font(.largeTitle).bold()
                        .foregroundStyle(.white)
                    
                    AsyncImage(url: URL(string: singlePokemon.sprites.front_default)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 350)
                            .offset(y: -20)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                    
                    VStack {
                        
                        HStack(spacing: 50) {
                            //  TabButton(
                            TabButton(title: "Stats", selected: $selectedTab, tab: .stats)
                            
                            TabButton(title: "Moves", selected: $selectedTab, tab: .moves)
                            
                            TabButton(title: "Abilities", selected: $selectedTab, tab: .abilities)
                        }
                        
                        //
                        VStack {
                            switch selectedTab {
                            case .stats:
                                StatsView(singlePokemon: singlePokemon)
                            case .moves:
                                MovesView(singlePokemon: singlePokemon)
                            case .abilities:
                                AbilitiesView(singlePokemon: singlePokemon)
                            }
                            
                        }
                        
                        
                        Spacer()
                        
                    }
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous).inset(by: 0))
                    
                    .ignoresSafeArea()
                    
                }
            }
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Acción para regresar
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left") // Puedes usar un ícono personalizado
                            .foregroundColor(.white) // Cambiar el color del ícono
                            .font(.title)
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailPokemonView(singlePokemon: PokemonsModelResponse( abilities: [Abilities(ability: Abilities.Ability(name: "Electric")), Abilities(ability: Abilities.Ability(name: "Water power"))], moves: [Moves(move: Moves.Move(name: "Razor-wind"))], stats: [Stats(base_stat: 45, effort: 0, stat: Stats.Stat(name: "hp"))] , sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [Types(type: Types.TypeResponse(name: "water"))], id: 1, name: "Bulbasaur", weight: 69, height: 7))
}
