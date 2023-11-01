//
//  ListCharactersFeatureTests.swift
//  HarryPotterTests
//
//  Created by immanuel nowpert on 31/10/23.
//

import XCTest
import ComposableArchitecture

@testable import HarryPotter

@MainActor
final class ListCharactersFeatureTests: XCTestCase {

    let mockRepsonse = IdentifiedArrayOf(uniqueElements:  [Character(id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter", gender: "male", house: "gryfindor", image: "hcahkc", patronus: "uaciucha", hogwartsStudent: false, hogwartsStaff: true)])
    
    // unit test to check if response from API is set to state successfully
    func testGetCharacters () async {
        let store = TestStore(initialState: ListCharactersFeature.State(), reducer:{
            ListCharactersFeature()
        })
            {
            $0.getCharacters.fetch = {
                .success([Character(id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter", gender: "male", house: "gryfindor", image: "hcahkc", patronus: "uaciucha", hogwartsStudent: false, hogwartsStaff: true)])
            }
        }

        
        await store.send(.getCharacters)
        
        await store.receive(/ListCharactersFeature.Action.insertCharacters, timeout: .seconds(2)) { state in
            state.characters = self.mockRepsonse
        }
        
       
        
        await store.finish()
        
        
    }

}
