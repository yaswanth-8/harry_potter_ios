//
//  CharacterDetailFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
import ComposableArchitecture

struct CharacterDetailFeature : Reducer {
    struct State : Equatable {
        var character : Character
    }
    enum Action {
        case saveCharacterButtonTapped
        case delegate(Delegate)
        enum Delegate {
            case saveCharacter(Character)
        }
    }
    var body : some ReducerOf<Self>{
        Reduce { state,  action in
            switch action {
            case .saveCharacterButtonTapped:
                state.character.isSaved.toggle()
                return .send(.delegate(.saveCharacter(state.character)))
            case .delegate:
                return .none
            }
        }
    }
}
