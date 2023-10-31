//
//  ListCharactersFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
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


