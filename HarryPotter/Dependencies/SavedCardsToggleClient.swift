//
//  SavedCardsToggle.swift
//  HarryPotter
//
//  Created by Yaswanth on 02/11/23.
//

import Foundation
import ComposableArchitecture
import MutateArray

struct ToggleFavoriteCardsClient {
    var toggle : (_ charactersArray :inout IdentifiedArrayOf<Character>, _ character : Character ) -> IdentifiedArrayOf<Character>
}

extension ToggleFavoriteCardsClient : DependencyKey {
    static var liveValue: Self {
        Value { charactersArray, character  in
            return appendOrRemoveFromArray(&charactersArray, character)
        }
    }
}

extension DependencyValues {
    var characterIsSaved : ToggleFavoriteCardsClient{
        get  {
            self[ToggleFavoriteCardsClient.self]
        }
        
        set {
            self [ToggleFavoriteCardsClient.self] = newValue
        }
    }
}
