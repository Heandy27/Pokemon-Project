//
//  Pokemon_ProjectApp.swift
//  Pokemon Project
//
//  Created by Andy Heredia on 18/3/25.
//

import SwiftUI

@main
struct Pokemon_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AppStateVM())
        }
    }
}
