//
//  RootView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 29/3/25.
//

import SwiftUI

struct RootView: View {
    
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        switch appState.status {
        case .errorApp:
            ErrorView()
        case .loading:
            LoadingView()
        case .success:
            PokemonsHomeView()
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
