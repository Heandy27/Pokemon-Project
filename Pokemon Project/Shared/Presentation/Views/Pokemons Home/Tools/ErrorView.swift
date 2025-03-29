//
//  ErrorView.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 29/3/25.
//

import SwiftUI

struct ErrorView: View {
    
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        ZStack {
            Image("")
                .resizable()
                .background(Color.red)
            VStack{
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.white)
                    .font(.system(size: 80))
                    .padding()
                Text("Something went wrong, try it again.")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                Button {
                    //Action Here
                    appState.status = .loading
                } label: {
                    Text("Try Again")
                        .foregroundStyle(.red)
                        .font(.title2)
                }
                .frame(width: 250, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
        }
    }
}

#Preview {
    ErrorView()
        .environment(AppStateVM())
}
