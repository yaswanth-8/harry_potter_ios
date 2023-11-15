//
//  Spell.swift
//  HarryPotter
//
//  Created by Yaswanth on 02/11/23.
//

import Foundation

struct Spell : Codable, Equatable, Identifiable {
    var id : String
    var name : String
    var description : String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init(_ id: String, _ name : String, _ description : String){
        self.id = id
        self.name = name
        self.description = description
    }
}

var mockspell = Spell("spellId", "Wingardium Leviosa", "Causes an object to levitate; but remember what Hermione said: \"It's Wing-gar-dium Levi-o-sa, make the 'gar' nice and long.\"")

