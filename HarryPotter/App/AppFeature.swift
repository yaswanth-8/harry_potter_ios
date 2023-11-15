//
//  AppFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
import ComposableArchitecture
import MutateArray

enum Tab {
    case characters
    case spells
    case saved
    case game
}

struct AppFeature : Reducer {
    struct State {
        var selectedTab : Tab = .characters
        var charactersList = ListCharactersFeature.State()
        var savedCharactersList = SavedCharactersFeature.State()
        var game = GameFeature.State()
        var spellsList = SpellsFeature.State()
        var path = StackState <Path.State>()
    }
    enum Action {
        case charactersList(ListCharactersFeature.Action)
        case savedCharacters(SavedCharactersFeature.Action)
        case spellsList(SpellsFeature.Action)
        case game(GameFeature.Action)
        case path (StackAction<Path.State, Path.Action>)
    }
    
    
    
    @Dependency (\.characterIsSaved) var characterIsSaved
    var body: some ReducerOf<Self> {
        Scope(state: \.charactersList, action: /Action.charactersList){
            ListCharactersFeature()
        }
        Scope(state: \.savedCharactersList, action: /Action.savedCharacters){
            SavedCharactersFeature()
        }
        Scope(state: \.spellsList, action: /Action.spellsList){
            SpellsFeature()
        }
        Scope(state: \.game, action: /Action.game){
            GameFeature()
        }
        Reduce { state, action in
            switch action {
            case let .path(.element(id: _, action: .characterDetail(.delegate(action)))):
                switch action {
                case let .saveCharacter(character):
                    state.charactersList.characters[id : character.id]?.isSaved.toggle()
                    state.savedCharactersList.characters=characterIsSaved.toggle(&state.savedCharactersList.characters, character)
                    return .none
                }
                
            case .charactersList(.delegate(.syncReceivedAndSaved)):
                print("in sync received and saved state")
                syncSavedAndReceived(&state.charactersList.characters, state.savedCharactersList.characters)
                return .none
            case .charactersList(.delegate(.removeCharacter(let character))):
                if let index = state.charactersList.characters.firstIndex(where: {$0.id == character.id}){
                    state.charactersList.characters.remove(at : index)
                }
                if let index = state.savedCharactersList.characters.firstIndex(where: {$0.id == character.id}){
                    state.savedCharactersList.characters.remove(at : index)
                }
                return .none
            case .charactersList(_):
                return .none
            case .path(_):
                return .none
            case .spellsList(_):
                return .none
            case .game(_):
                  return  .none
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

//func appendOrRemoveFromArray<T: Equatable>(_ inputArray: inout IdentifiedArrayOf<T>, _ element: T) -> IdentifiedArrayOf<T> {
//    if let index = inputArray.firstIndex(where: { $0.id == element.id }) {
//        print("element exists so remove call")
//        inputArray.remove(at: index)
//    } else {
//        print("element doesnt exist so append")
//        inputArray.append(element)
//    }
//    return inputArray
//}
func syncSavedAndReceived(_ receivedCharacters:inout IdentifiedArrayOf<Character>,_ savedCharacters : IdentifiedArrayOf<Character>){
    for i in 0..<receivedCharacters.count {
        let character = receivedCharacters[i]
        
        if savedCharacters.contains(where: { $0.id == character.id }) {
            receivedCharacters[i].isSaved = true
        }
    }
}

