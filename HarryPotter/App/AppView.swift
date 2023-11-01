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
        NavigationStackStore(self.store.scope(state: \.path, action: {.path($0)}),
        root: {
            TabView{
                
                ListCharactersView(store: self.store.scope(state: \.charactersList, action: {.charactersList($0)}))
                    .tabItem {
                            Image(systemName: "house.fill")
                    }
                    .tag(Tab.saved)
                
                SavedCharactersView(store: self.store.scope(state:\.savedCharactersList, action: {.savedCharacters($0)}))
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                    }
                    .tag(Tab.student)
            }
        },
        destination: {
            state in
            switch state {
            case .characterDetail:
                CaseLet(
                    /AppFeature.Path.State.characterDetail,
                     action: AppFeature.Path.Action.characterDetail,
                     then: CharacterDetailView.init(store:)
                )
            }
        })
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State() , reducer: {
        AppFeature()
    }))
}
