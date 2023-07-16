//
//  TagStructure.swift
//  Word
//
//  Created by 胡宗禹 on 7/4/23.
//

import Foundation

struct singleTag: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var color: String
}
