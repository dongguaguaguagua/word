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
    var isShow: Bool = true
    var tag: [String]
}
///十六进制颜色扩展
///链接：https://juejin.cn/post/6948250295549820942
