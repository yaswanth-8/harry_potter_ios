//
//  CharacterDetailView.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailView: View {
    var store : StoreOf<CharacterDetailFeature>
    var body: some View {
        Text("Detail")
    }
}

#Preview {
    CharacterDetailView(store: Store(initialState: CharacterDetailFeature.State(character: mockCharacter), reducer: {
        CharacterDetailFeature()
    }))
}
