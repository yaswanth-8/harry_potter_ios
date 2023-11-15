//
//  RandomCardFeature.swift
//  HarryPotter
//
//  Created by Yaswanth on 03/11/23.
//

import Foundation
import ComposableArchitecture

struct RandomCardFeature : Reducer {
    struct State : Equatable{
        var characters : IdentifiedArrayOf<Character> = []
        var chosenImageUrl : String = loadingImage
    }
    enum Action {
        case getCharacters(String)
    }
    var body : some ReducerOf<Self>{
        Reduce { state,action in
            switch action {
            case .getCharacters(_):
                return .none
            }
        }
    }
}

func getRandomElement<T>(_ inputArray : [T]) -> T{
    inputArray.randomElement()!
}
