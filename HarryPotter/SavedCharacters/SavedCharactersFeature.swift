//
//  SavedCharactersFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
import ComposableArchitecture

struct SavedCharactersFeature : Reducer{
    struct State : Equatable{
        var characters : IdentifiedArrayOf<Character> = [mockCharacter]
    }
    enum Action{
        
    }
    var body : some ReducerOf<Self> {
        Reduce { state, action in
            switch action{
                
            }
        }
    }
}
