//
//  GameFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 03/11/23.
//


import Foundation
import ComposableArchitecture

struct GameFeature : Reducer {
    struct State :Equatable {
        var playerTeam : House?
        var computerTeam : House?
        var gameModeOn : Bool = false
        var charactersOfGryffindor : IdentifiedArrayOf<Character> = []
        var charactersOfSlytherin : IdentifiedArrayOf<Character> = []
        var characterChosenFromGryffindor : Character?
        var characterChosenFromSlyherin : Character?
    }
    enum Action {
        case pickTeam
        case startGameButtonTapped
        case gameModeToggle
        case houseChosen(playerhouse : House, computerHouse : House)
        case getCharacters
        case insertCharactersGryffindor([Character])
        case insertCharactersSlytherin([Character])
    }
    
    @Dependency(\.getCharacters) var getCharacters
    
    var body : some ReducerOf<Self>{
        Reduce { state, action in
            switch action {
            case .pickTeam:
                return .none
            case .startGameButtonTapped:
                state.gameModeOn = true
                //print(state.charactersOfGryffindor)
                let filteredCharactersGryffindor = state.charactersOfGryffindor.filter { $0.image != "" }
                state.characterChosenFromGryffindor = filteredCharactersGryffindor.randomElement()
                let filteredCharactersSlytherin = state.charactersOfSlytherin.filter { $0.image != "" }
                state.characterChosenFromSlyherin = filteredCharactersSlytherin.randomElement()
//                print(characterChosenFromGryffindor ?? "didnt receive character")
//                print(characterChosenFromSlyherin ?? "didnt receive character")
                return .none
            case .gameModeToggle:
                return .none
            case .houseChosen(let playerHouse, let computerHouse):
                state.playerTeam = playerHouse
                state.computerTeam = computerHouse
                return .none
            case .getCharacters:
                return .run { send in
                    let getCharactersResponeGryffindor = await getCharacters.fetch("gryffindor")
                    switch getCharactersResponeGryffindor {
                    case .success(let Characters):
                        //print(Characters)
                        await send(.insertCharactersGryffindor(Characters))
                    case .failure(_):
                        print("Error occured")
                    }
                    let getCharactersResponeSlytherin = await getCharacters.fetch("slytherin")
                    switch getCharactersResponeSlytherin {
                    case .success(let Characters):
                        //print(Characters)
                        await send(.insertCharactersSlytherin(Characters))
                    case .failure(_):
                        print("Error occured")
                    }
                }
            case .insertCharactersGryffindor(let characters):
                state.charactersOfGryffindor = IdentifiedArray(uniqueElements: characters)
                return .none
            case .insertCharactersSlytherin(let characters):
                state.charactersOfSlytherin = IdentifiedArray(uniqueElements: characters)
                return .none
            }
        }
    }
}

