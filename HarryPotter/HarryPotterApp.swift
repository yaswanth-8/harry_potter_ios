//
//  HarryPotterApp.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct HarryPotterApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State() , reducer: {
                AppFeature()._printChanges()
            }))
        }
    }
}
