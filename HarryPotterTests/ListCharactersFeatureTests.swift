//
//  ListCharactersFeatureTests.swift
//  HarryPotterTests
//
//  Created by immanuel nowpert on 31/10/23.
//

import Foundation
import XCTest
import ComposableArchitecture

@testable import HarryPotter

@MainActor
final class ListCharactersFeatureTests : XCTestCase {
    
    func getCharactersTest () async {
        let store = Store(initialState: ListCharactersFeature.State(), reducer: ListCharactersFeature()) {
            $0.getCharacters.fetch = {
            
            }
        }
    }
}
