//
//  RandomCardView.swift
//  HarryPotter
//
//  Created by Yaswanth on 03/11/23.
//

import SwiftUI
import ComposableArchitecture

struct RandomCardView: View {
    //let store : StoreOf<RandomCardFeature>
    let url : String
    var body: some View {
            ImageCardLayout(urlString: url)
            .onAppear{
                print("card view appeared")
            }
    }
}

#Preview {
    RandomCardView(url: mockImage)
}
