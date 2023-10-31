//
//  AppFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
import ComposableArchitecture

enum Tab {
    case student
    case teacher
}

struct AppFeature : Reducer {
    struct State {
        var selectedTab : Tab = .student
        var charactersList = ListCharactersFeature.State()
    }
    enum Action {
        case charactersList(ListCharactersFeature.Action)
    }
    var body: some ReducerOf<Self> {
        Scope(state: \.charactersList, action: /Action.charactersList){
            ListCharactersFeature()
        }
        Reduce { state, action in
            switch action {
            case .charactersList(_):
                return .none
            }
        }
    }
}
