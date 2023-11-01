//
//  ListCharacters.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ListCharactersView: View {
    let store : StoreOf<ListCharactersFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(spacing:0),GridItem(spacing:0)],spacing: 0, content: {
                    ForEach(viewStore.characters){character in
                        
                        if let url = character.image  , !url.isEmpty {
                            NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: character))) {
                                AsyncImage(url: URL(string: url)){
                                    Image in
                                    Image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:200,height: 300)
                                }placeholder: {
                                    ProgressView()
                                    
                                }
                            }
                        }
                    }
                }
                        )
                
                            .task{
                            viewStore.send(.getCharacters)
                        }
                    }.ignoresSafeArea(edges:.top)
        }
    }
}
                          

#Preview {
    ListCharactersView(store: Store(initialState: ListCharactersFeature.State(), reducer: {
        ListCharactersFeature()
            ._printChanges()
    }))
}
