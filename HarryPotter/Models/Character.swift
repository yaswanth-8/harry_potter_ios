

import Foundation

struct Character : Codable, Equatable,  Identifiable {
    var id : String?
    var name : String?
    var gender : String?
    var house : String?
    var image : String?
    var patronus : String?
    var hogwartsStudent : Bool?
    var hogwartsStaff : Bool?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.house = try container.decodeIfPresent(String.self, forKey: .house)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.patronus = try container.decodeIfPresent(String.self, forKey: .patronus)
        self.hogwartsStudent = try container.decodeIfPresent(Bool.self, forKey: .hogwartsStudent)
        self.hogwartsStaff = try container.decodeIfPresent(Bool.self, forKey: .hogwartsStaff)
    }
}
