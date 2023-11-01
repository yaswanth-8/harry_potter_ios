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
    enum Action :Equatable{
        case favoriteButtonTapped
    }
    var body : some ReducerOf<Self>{
        Reduce { state,  action in
            switch action {
            case .favoriteButtonTapped:
                return .none
            }
        }
    }
}
