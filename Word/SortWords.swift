//
//  SortWords.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import Foundation

enum SortMode: String, CaseIterable, Identifiable {
    case byDateUp, byDateDown, byNameUp, byNameDown, random
    var id: Self { self }
}


