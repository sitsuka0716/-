

import Foundation
import UIKit

struct HolidayResults: Codable {
    struct Holiday : Codable {
        var date : String
        var description : String
        var holidayCategory : String
        var isHoliday : String
        var name : String
    }
    var resultCount: Int
    var results: [Holiday]
}

struct Schedule: Codable{
    var event: String
    var date: String
    var time: String
    var position: String
    var memo: String
    
    static func readSchedulesFromFile() -> [Schedule]? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "schedules"), let schedules = try? propertyDecoder.decode([Schedule].self, from: data) {
            return schedules
        } else {
            return nil
        }
    }
    
    static func saveToFile(schedules: [Schedule]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(schedules) {
            UserDefaults.standard.set(data, forKey: "schedules")
        }
    }
}

