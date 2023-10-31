

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
    


    
    init(id : String, name : String, gender : String, house : String, image : String, patronus : String, hogwartsStudent : Bool, hogwartsStaff : Bool){
        self.id = id
        self.name = name
        self.gender = gender
        self.house = house
        self.image = image
        self.patronus = patronus
        self.hogwartsStudent = hogwartsStudent
        self.hogwartsStaff = hogwartsStaff
    }

}


let mockCharacter : Character = Character(id: "abc", name: "Harry", gender: "male", house: "gryffindor", image: "https://ik.imagekit.io/hpapi/ginny.jpg", patronus: "deer", hogwartsStudent: true, hogwartsStaff: false)
