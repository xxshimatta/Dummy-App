//
//  Order.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import Foundation

struct Order: Identifiable, Codable{
    var id: String
    var name: String
    var items: [String]
    var total: Double
    
    enum CodingKeys:String,CodingKey{
        case id, name, items, total
    }
}
