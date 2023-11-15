//
//  SwiftUIView.swift
//  HarryPotter
//
//  Created by Yaswanth on 03/11/23.
//

import SwiftUI
import ComposableArchitecture

struct GameView: View {
    let store : StoreOf<GameFeature>
    @State var showChooseTeam : Bool = true
    @State var showPlay : Bool = true
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VStack{
                if (viewStore.gameModeOn){
                    Spacer()
                    Text("Gryffindor")
                    NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: viewStore.characterChosenFromGryffindor!))) {
                        ImageCardLayout(urlString: viewStore.characterChosenFromGryffindor?.image ?? "")
                    }
                }
                if(!viewStore.charactersOfGryffindor.isEmpty && !viewStore.charactersOfSlytherin.isEmpty){
                    Button{
                        showPlay = false
                        viewStore.send(.startGameButtonTapped)
                    }label: {
                        HStack {
                            Text("Battle")
                            Image(systemName: "wand.and.stars")
                        }
                        .foregroundColor(.blue)
                        .padding()
                        .border(Color.blue)
                    }
                    .padding()
                }
                else {
                    Button{
                        viewStore.send(.startGameButtonTapped)
                    }label: {
                        HStack {
                            Image(systemName: "ellipsis")
                        }
                        .foregroundColor(.blue)
                        .padding()
                        .border(Color.blue)
                    }
                }
                if (viewStore.gameModeOn){
                    Spacer()
                    Spacer()
                    Text("Slytherin")
                    NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: viewStore.characterChosenFromSlyherin!))) {
                        ImageCardLayout(urlString: viewStore.characterChosenFromSlyherin?.image ?? "")
                    }
                }
            }
            .alert(isPresented: $showChooseTeam, content: {
                Alert(
                title: Text("Choose Team"),
                primaryButton: .default(Text("Gryffindor")) {
                    viewStore.send(.houseChosen(playerhouse: House.Gryffindor, computerHouse: House.Slytherin))
                    viewStore.send(.getCharacters)
                },
                secondaryButton: .default(Text("Slytherin")) {
                    viewStore.send(.houseChosen(playerhouse: House.Slytherin, computerHouse: House.Gryffindor))
                    viewStore.send(.getCharacters)
                }
            )
            })
        }
    }
}

#Preview {
    GameView(store: Store(initialState: GameFeature.State(playerTeam: .Gryffindor, computerTeam: .Slytherin), reducer: {
        GameFeature()._printChanges()
    }))
}
