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
    case saved
}

struct AppFeature : Reducer {
    struct State {
        var selectedTab : Tab = .student
        var charactersList = ListCharactersFeature.State()
        var savedCharactersList = SavedCharactersFeature.State()
        var path = StackState <Path.State>()
    }
    enum Action {
        case charactersList(ListCharactersFeature.Action)
        case savedCharacters(SavedCharactersFeature.Action)
        case path (StackAction<Path.State, Path.Action>)
    }
    var body: some ReducerOf<Self> {
        Scope(state: \.charactersList, action: /Action.charactersList){
            ListCharactersFeature()
        }
        Scope(state: \.savedCharactersList, action: /Action.savedCharacters){
            SavedCharactersFeature()
        }
        Reduce { state, action in
            switch action {
            case .charactersList(_):
                return .none
            case let .path(.element(id: _, action: .characterDetail(.delegate(action)))):
                switch action {
                case let .saveCharacter(character):
                    state.charactersList.characters[id : character.id]?.isSaved.toggle()
                    print("getting toggled")
                    if let index = state.savedCharactersList.characters.firstIndex(where: { $0.id == character.id }) {
                        // Character exists, so remove it
                        state.savedCharactersList.characters.remove(at: index)
                    } else {
                        // Character doesn't exist, so append it
                        state.savedCharactersList.characters.append(character)
                    }
                    print("\(state.savedCharactersList.characters.count) is the count of saved characters")
                    return .none
                }
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: /Action.path){
            Path()
        }
    }
    
    struct Path : Reducer {
        enum State {
            case characterDetail(CharacterDetailFeature.State)
        }
        enum Action {
            case characterDetail(CharacterDetailFeature.Action)
        }
        var body : some ReducerOf<Self> {
            Scope(state: /State.characterDetail, action: /Action.characterDetail){
                CharacterDetailFeature()
            }
        }
    }
    
}
