//
//  WordStructure.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Foundation

struct singleWord:Hashable,Codable,Identifiable{
    var id = UUID()
    var name: String
    var definition: String
    var date: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case definition
//        case date
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(definition, forKey: .definition)
//        try container.encode(date, forKey: .date)
//    }
}
