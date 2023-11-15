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
                            Image(systemName: "person.fill")
                            
                    }
                    .tag(Tab.characters)
                
                SavedCharactersView(store: self.store.scope(state:\.savedCharactersList, action: {.savedCharacters($0)}))
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                    }
                    .tag(Tab.saved)
                
                SpellsView(store: self.store.scope(state: \.spellsList, action: {.spellsList($0)}))
                    .tabItem {
                        Image(systemName: "star.leadinghalf.filled")
                    }
                    .tag(Tab.characters)
                
                GameView(store: self.store.scope(state: \.game, action: {.game($0)}))
                    .tabItem {
                        Image(systemName: "gamecontroller.fill")
                    }
                    .tag(Tab.game)
            }
            
        }
        ,
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
