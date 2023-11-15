//
//  ListCharacters.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ListCharactersView: View {
    let store : StoreOf<ListCharactersFeature>
    
//    let gridLayout : [GridItem] = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//    ]
    
    let gridLayout : [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            NavigationView{
                ZStack {
                    ScrollView(.vertical) {
                            LazyVGrid(columns: gridLayout ,spacing: 0, content: {
                                ForEach(viewStore.characters){character in
                                    if let url = character.image  , !url.isEmpty {
                                        if(viewStore.charactercategorySelected == .Student && (character.hogwartsStudent == true) && character.hogwartsStaff != true){
                                            NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: character))) {
                                                
                                                ZStack {
                                                    ImageCardLayout(urlString: url)
                                                }
                                                
                                                
                                                    .contextMenu(ContextMenu(menuItems: {
                                                        Button("Delete", systemImage: "trash.fill"){
                                                            viewStore.send(.delegate(.removeCharacter(character)))
                                                        }
                                                    }))
                                            }
                                        }
                                        else if(viewStore.charactercategorySelected == .Teacher && (character.hogwartsStudent != true) && character.hogwartsStaff == true){
                                            NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: character))) {
                                                ImageCardLayout(urlString: url)
                                                    .contextMenu(ContextMenu(menuItems: {
                                                        Button("Delete", systemImage: "trash.fill"){
                                                            viewStore.send(.delegate(.removeCharacter(character)))
                                                        }
                                                    }))
                                            }
                                        }
                                        else if(viewStore.charactercategorySelected == .Both){
                                            NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: character))) {
                                                 ImageCardLayout(urlString: url)
                                                    .contextMenu(ContextMenu(menuItems: {
                                                        Button("Delete", systemImage: "trash.fill"){
                                                            viewStore.send(.delegate(.removeCharacter(character)))
                                                        }
                                                    }))
                                            }
                                        }
                                    }
                                }
                            }
                                    )
                            
                                        .task{
                                        viewStore.send(.getCharacters)
                                    }
                                
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Menu("House", systemImage: "house"){
                                Button(House.Gryffindor.rawValue){viewStore.send(.chooseHouseButtonTapped(House.Gryffindor.rawValue))}
                                Button(House.Slytherin.rawValue){viewStore.send(.chooseHouseButtonTapped(House.Slytherin.rawValue))}
                                Button(House.Hufflepuff.rawValue){viewStore.send(.chooseHouseButtonTapped(House.Hufflepuff.rawValue))}
                                Button(House.Ravenclaw.rawValue){viewStore.send(.chooseHouseButtonTapped(House.Ravenclaw.rawValue))}
                            }
                            .padding(10)
                            .background()
                            .cornerRadius(10)
                            Menu(viewStore.charactercategorySelected.rawValue, systemImage: "figure.stand"){
                                Button(characterCategory.Student.rawValue){
                                    viewStore.send(.chooseCharacterCategoryButtonTapped(.Student))
                                }
                                Button(characterCategory.Teacher.rawValue){
                                    viewStore.send(.chooseCharacterCategoryButtonTapped(.Teacher))
                                }
                                Button(characterCategory.Both.rawValue){
                                        viewStore.send(.chooseCharacterCategoryButtonTapped(.Both))
                                    }
                            }
                            .padding(10)
                            .background()
                            .cornerRadius(10)
                        }
                        .frame(height: 100)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Characters")
                .toolbar {
                    ToolbarItem{
                        Button{
                            viewStore.send(.refreshButtonTapped)
                        }label:{
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
            
        }
    }
}
                          

#Preview {
    NavigationStack{
        ListCharactersView(store: Store(initialState: ListCharactersFeature.State(), reducer: {
            ListCharactersFeature()
        }))
    }
}
