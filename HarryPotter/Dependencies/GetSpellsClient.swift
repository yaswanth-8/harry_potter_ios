//
//  GetSpellsClient.swift
//  HarryPotter
//
//  Created by Yaswanth on 02/11/23.
//

import Foundation
import ComposableArchitecture

struct GetSpellsClient  {
    var fetchSpells : () async -> Result<[Spell], ApiError>
}

extension GetSpellsClient : DependencyKey{
    static var liveValue = Self {
    fetchSpells: do {
        guard let url = URL(string: "https://hp-api.onrender.com/api/spells") else {
            return .failure(.invalidUrl)
        }
        guard let (data,_) = try? await URLSession.shared.data(from: url) else {
            return .failure(.invalidData)
        }
        
        guard let spells = try? JSONDecoder().decode([Spell].self, from: data) else {
            return .failure(.dataMismatch)
        }
        return .success(spells)
    }
    }
}

extension DependencyValues {
    var getSpells : GetSpellsClient{
        get  {
            self[GetSpellsClient.self]
        }
        
        set {
            self [GetSpellsClient.self] = newValue
        }
    }
}
