//
//  DictStructure.swift
//  Word
//
//  Created by 胡宗禹 on 7/10/23.
//

import Foundation

struct DictStruct: Hashable, Codable {
    var id: Int
    var name: String
    var phonetic: String
    var definition: String
    var translation: String
    var collins: Int
    var oxford: Int
    var tag: String
    var bnc: Int
    var frq: Int
    var exchange: String
}
