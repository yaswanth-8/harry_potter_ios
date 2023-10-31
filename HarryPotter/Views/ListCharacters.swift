//
//  ListCharacters.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ListCharactersFeature : Reducer {
    struct State : Equatable {
        var characters : IdentifiedArrayOf<Character> = []
    }
    
    enum Action {
        case getCharacters
        case insertCharacters([Character])
    }
    
    @Dependency (\.getCharacters) var getCharacters
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getCharacters:
                return .run { send in
                    let getCharactersRespone = await getCharacters.fetch()
                    switch getCharactersRespone {
                    case .success(let Characters):
                        await send(.insertCharacters(Characters))
                    case .failure(_):
                        print("Error occured")
                    }
                }
                
            case .insertCharacters(let characters):
                state.characters = IdentifiedArray(uniqueElements: characters)
                print(characters)
                return .none
            }
        }
    }
}





struct ListCharacters: View {
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
    ListCharacters(store: Store(initialState: ListCharactersFeature.State(), reducer: {
        ListCharactersFeature()
    }))
}
