import Foundation
struct Location : Codable {
    let street : Street?
    let city : String?
    let state : String?
    let country : String?
    let postcode : Postcode?
    let coordinates : Coordinates?
    let timezone : Timezone?
    
        enum CodingKeys: String, CodingKey {
            
            case street = "street"
            case city = "city"
            case state = "state"
            case country = "country"
            case postcode = "postcode"
            case coordinates = "coordinates"
            case timezone = "timezone"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            street = try values.decodeIfPresent(Street.self, forKey: .street)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            state = try values.decodeIfPresent(String.self, forKey: .state)
            country = try values.decodeIfPresent(String.self, forKey: .country)
            postcode = try values.decodeIfPresent(Postcode.self, forKey: .postcode)
            coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
            timezone = try values.decodeIfPresent(Timezone.self, forKey: .timezone)
        }
        
    }
