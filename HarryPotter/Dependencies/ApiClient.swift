//
//  ApiClient.swift
//  HarryPotter
//
//  Created by Yaswanth on 31/10/23.
//

import Foundation
import ComposableArchitecture

enum ApiError : Error {
    case invalidUrl
    case invalidData
    case dataMismatch
}

struct GetCharactersClient  {
    var fetch : () async -> Result<[Character],ApiError>
}

extension GetCharactersClient : DependencyKey{
    static var liveValue = Self {
        fetch : do {
            guard let url = URL(string: "https://hp-api.onrender.com/api/characters/house/gryffindor") else {
                return .failure(.invalidUrl)
            }
            guard let (data,_) = try? await URLSession.shared.data(from: url) else {
                return .failure(.invalidData)
            }
            
            guard let characters = try? JSONDecoder().decode([Character].self, from: data) else {
                return .failure(.dataMismatch)
            }
            return .success(characters)
        }
    }

}

extension DependencyValues {
    var getCharacters : GetCharactersClient{
        get  {
            self[GetCharactersClient.self]
        }
        
        set {
            self [GetCharactersClient.self] = newValue
        }
    }
}
