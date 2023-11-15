//
//  ListCharactersFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
import ComposableArchitecture
import Combine

struct ListCharactersFeature : Reducer {
    struct State : Equatable {
        var characters : IdentifiedArrayOf<Character> = []
        var activeHouseListName : String = House.Gryffindor.rawValue
        var charactercategorySelected : characterCategory = .Both
    }
    
    enum Action {
        case getCharacters
        case insertCharacters([Character])
        case chooseHouseButtonTapped(String)
        case chooseCharacterCategoryButtonTapped(characterCategory)
        case refreshButtonTapped
        case delegate(Delegate)
        enum Delegate {
            case syncReceivedAndSaved
            case removeCharacter(Character)
        }
    }
    
    @Dependency (\.getCharacters) var getCharacters
    var body: some Reducer<State,Action>{
        Reduce { state, action in
            switch action {
            case .getCharacters:
                print("get characters called")
                if !state.characters.isEmpty {
                    return .none
                }
                return .run { [activeHouseListName = state.activeHouseListName] send in
                    let getCharactersRespone = await getCharacters.fetch(activeHouseListName)
                    switch getCharactersRespone {
                    case .success(let Characters):
                        await send(.insertCharacters(Characters))
                    case .failure(_):
                        print("Error occured")
                    }
                }
                
            case .insertCharacters(let characters):
                state.characters = IdentifiedArray(uniqueElements: characters)
                print("Fetched characters")
                return .send(.delegate(.syncReceivedAndSaved))
            case .chooseHouseButtonTapped(let HouseName):
                state.activeHouseListName = HouseName
                return .none
            case .delegate(_):
                return .none
            case .chooseCharacterCategoryButtonTapped(let characterCategory):
                state.charactercategorySelected = characterCategory
                return .none
            case .refreshButtonTapped:
                state.characters = []
                return .send(.getCharacters)
            }
        }
        .onChange(of: \.activeHouseListName) { oldValue, newValue in
            Reduce { state, action in
                state.characters = []
                return .send(.getCharacters)
            }
        }
    }
}

enum House : String {
    case Gryffindor
    case Slytherin
    case Hufflepuff
    case Ravenclaw
}

enum characterCategory : String{
    case Both
    case Student
    case Teacher
}

