//
//  holiday.swift
//  Day2Day
//
//  Created by Kam Hong Chan on 19/06/2018.
//  Copyright © 2018 Kam Hong Chan. All rights reserved.
//

import Foundation
import UIKit

import Foundation

struct Result : Codable {
    
    let fields : [Field]?
    let limit : Int?
    let records : [Record]?
    let resourceId : String?
    let total : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case fields = "fields"
        case limit = "limit"
        case records = "records"
        case resourceId = "resource_id"
        case total = "total"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fields = try values.decodeIfPresent([Field].self, forKey: .fields)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        records = try values.decodeIfPresent([Record].self, forKey: .records)
        resourceId = try values.decodeIfPresent(String.self, forKey: .resourceId)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
    
    
}
}
