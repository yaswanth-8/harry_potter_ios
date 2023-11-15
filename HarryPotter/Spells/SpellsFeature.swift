//
//  SpellsFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 02/11/23.
//

import Foundation
import ComposableArchitecture

struct SpellsFeature : Reducer {
    struct State : Equatable{
        var spells : IdentifiedArrayOf<Spell> = []
    }
    enum Action {
        case fetch
        case insertSpells([Spell])
    }
    @Dependency(\.getSpells) var getSpells
    var body : some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetch:
                return .run { send in
                    let getSpellsResponse = await getSpells.fetchSpells()
                    switch getSpellsResponse {
                    case .success(let spellsReceived):
                        await send(.insertSpells(spellsReceived))
                    case .failure(_):
                        print("Error occured")
                    }
                }
            case .insertSpells(let spells):
                state.spells = IdentifiedArray(uniqueElements: spells)
                return .none
            }
        }
    }
}
