//
//  LoadingView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 29/3/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Image(.loading)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            Color.black.opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                ProgressView()
                    .tint(.white)
                Text("Loading...")
                    .foregroundStyle(.white)
                
            }
            
            
        }
        
        
    }
}

#Preview {
    LoadingView()
}
