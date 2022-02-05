import Foundation
struct Picture : Codable {
	let large : String?
	let medium : String?
	let thumbnail : String?

	enum CodingKeys: String, CodingKey {

		case large = "large"
		case medium = "medium"
		case thumbnail = "thumbnail"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		large = try values.decodeIfPresent(String.self, forKey: .large)
		medium = try values.decodeIfPresent(String.self, forKey: .medium)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
	}

}
