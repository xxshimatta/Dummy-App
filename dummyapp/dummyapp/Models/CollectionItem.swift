//
//  CollectionItem.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import Foundation
struct CollectionItem: Identifiable, Codable {
    var id = UUID()
    var category:String
    var name:String
    var price:Double
    var stock:Bool
    
    enum CodingKeys:String,CodingKey{
        case category, name, price, stock
    }
}

let collectionCategory = [
    "Household",
    "Industry",
    "Electronics",
    "Cleaning"
]
