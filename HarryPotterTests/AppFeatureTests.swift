//
//  AppFeatureTests.swift
//  HarryPotterTests
//
//  Created by immanuel nowpert on 31/10/23.
//

import Foundation
import ComposableArchitecture
@testable import HarryPotter
import XCTest

@MainActor
final class AppFeatureTests : XCTestCase {
    
    let store = TestStore(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    func testPath() async {
        await store.send(.path(.push(id: _, state:)))
    }
    
    
    
   
    
}
