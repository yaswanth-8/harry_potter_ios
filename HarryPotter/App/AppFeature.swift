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
    struct State :Equatable{
        var selectedTab : Tab = .student
        var charactersList = ListCharactersFeature.State()
        var path = StackState <Path.State>()
    }
    enum Action :Equatable{
        case charactersList(ListCharactersFeature.Action)
        case path (StackAction<Path.State, Path.Action>)
    }
    var body: some ReducerOf<Self> {
        Scope(state: \.charactersList, action: /Action.charactersList){
            ListCharactersFeature()
        }
        Reduce { state, action in
            switch action {
            case .charactersList(_):
                return .none
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: /Action.path){
            Path()
        }
    }
    
    struct Path : Reducer {
        enum State :Equatable{
            case characterDetail(CharacterDetailFeature.State)
        }
        enum Action: Equatable {
            case characterDetail(CharacterDetailFeature.Action)
        }
        var body : some ReducerOf<Self> {
            Scope(state: /State.characterDetail, action: /Action.characterDetail){
                CharacterDetailFeature()
            }
        }
    }
    
}
