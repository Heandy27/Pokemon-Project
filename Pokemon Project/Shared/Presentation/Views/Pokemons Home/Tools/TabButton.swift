//
//  TabButton.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 28/3/25.
//

import SwiftUI

struct TabButton: View {
    
    let title: String
    @Binding var selected: StatusDetail
    let tab: StatusDetail
    
    var body: some View {
        Button(action: {
            withAnimation {
                selected = tab
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(selected == tab ? .black : .gray)
                .padding(.bottom, 5)
                .overlay(
                    Rectangle()
                        .frame(height: selected == tab ? 3 : 0)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: StatusDetail = .stats
    
    TabButton(title: "Stats", selected: $selectedTab, tab: .stats)
}
