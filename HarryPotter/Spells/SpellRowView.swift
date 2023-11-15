//
//  SpellRowView.swift
//  HarryPotter
//
//  Created by Yaswanth on 02/11/23.
//

import SwiftUI

struct SpellRowView: View {
    let spell: Spell

    var body: some View {
        HStack {
            Text(spell.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
        .padding(10)
    }
}

#Preview {
    SpellRowView(spell : mockspell)
}
