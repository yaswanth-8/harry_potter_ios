//
//  AppView.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppFeature>
    var body: some View {
        ListCharactersView(store: self.store.scope(state: \.charactersList, action: {.charactersList($0)}))
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State() , reducer: {
        AppFeature()
    }))
}
