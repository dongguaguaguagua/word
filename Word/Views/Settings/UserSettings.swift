//
//  PropertyWrapper.swift
//  Word
//
//  Created by 胡宗禹 on 7/7/23.
//
import Foundation
import Combine

struct settings:Hashable,Codable{
    var showDetailDefinition:Bool
    var clickBottomToShuffle:Bool
    var recentSearchWord:[String]
    var disableAutoCorrection:Bool
    var enableMarkdown:Bool
    var enableFuzzySearch:Bool
    var fuzziness:Double
}
