//
//  WordStructure.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Foundation
import SwiftUI

struct singleWord:Hashable,Codable,Identifiable{
    var id = UUID()
    var name: String
    var definition: String
    var date: String
    var tag : [String]
}

