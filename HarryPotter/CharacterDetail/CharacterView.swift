//
//  CharacterView.swift
//  HarryPotter
//
//  Created by immanuel nowpert on 31/10/23.
//

import SwiftUI
import ComposableArchitecture

struct CharacterView: View {
    let store : StoreOf<CharacterDetailFeature>
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            
           if let image = viewStore.character.image {
               VStack(spacing:0){
                   AsyncImage(url: URL(string:image)) { Image in
                       Image
                           .resizable()
                           .frame(width:400,height: 500)
                           .aspectRatio(contentMode: .fit)
                          
                           
                       
                   } placeholder: {
                       ProgressView()
                   }
                   
                   HStack(alignment:.top){
                       VStack(alignment: .leading){
                           Text(viewStore.character.name ?? "")
                               .font(.title)
                               .fontWeight(.bold)
                           Text(viewStore.character.house ?? "")
                               .font(.title2)
                           
                           Spacer()
                           
                           HStack{
                               Image(systemName: "bird.fill")
                               Text(viewStore.character.patronus ?? "")
                               
                               Spacer()
                               
                               Image(systemName: "graduationcap.fill")
                               Text(viewStore.character.hogwartsStaff ?? false ? "student" : "tutor")
                           }
                               
                           Spacer()
                       }
                       .padding(10)
                       
                       Spacer()
                      
                       Image(systemName: "bookmark.fill")
                           .resizable()
                           .frame(width:20)
                           .frame(height:25)
                           .foregroundColor(.orange)
                           .padding(.top,30)
                       
                       
                   }
                   .padding(10)
                   
                   
                   
                   .foregroundColor(.white)
                   .background(Color.black.opacity(0.9))

               }
               
              
            }
        }
        
    }
}

#Preview {
    CharacterView(store: .init(initialState: CharacterDetailFeature.State(character: Character(id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter", gender: "male", house: "gryfindor", image: "https://ik.imagekit.io/hpapi/ginny.jpg", patronus: "uaciucha", hogwartsStudent: false, hogwartsStaff: true)), reducer: {
        CharacterDetailFeature()
    }))
}
