//
//  ListCharacters.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ListCharactersView: View {
    @State private var characters : [Character] = []
    let store : StoreOf<ListCharactersFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in 
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onAppear(){
                    viewStore.send(.getCharacters)
                }
        }
    }
}

#Preview {
    ListCharactersView(store: Store(initialState: ListCharactersFeature.State(), reducer: {
        ListCharactersFeature()
    }))
}
