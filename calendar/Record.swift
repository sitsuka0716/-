

import Foundation

struct Record : Codable {

	let date : String?
	let descriptionField : String?
	let holidayCategory : String?
	let isHoliday : String?
	let name : String?


	enum CodingKeys: String, CodingKey {
		case date = "date"
		case descriptionField = "description"
		case holidayCategory = "holidayCategory"
		case isHoliday = "isHoliday"
		case name = "name"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		holidayCategory = try values.decodeIfPresent(String.self, forKey: .holidayCategory)
		isHoliday = try values.decodeIfPresent(String.self, forKey: .isHoliday)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}


}
