//
//  WordStructure.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Foundation
import UIKit

struct singleWord:Hashable,Codable,Identifiable{
    var id = UUID()
    var name: String
    var definition: String
    var date: String
//    struct group{
//        var name: String
//        var color: UIColor
//    }
    var tag: [String]
}

//struct singleTag:Hashable,Codable,Identifiable{
//    
//}
