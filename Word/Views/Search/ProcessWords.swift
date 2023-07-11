//
//  ProcessInput.swift
//  Word
//
//  Created by 胡宗禹 on 7/10/23.
//

import Foundation
import SwiftUI

func processInput(str:String)->String{
    ///remove all whitespaces
    return str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
}

//https://w3toppers.com/highlight-a-specific-part-of-the-text-in-swiftui
func hilightedText(str: String, searched: String) -> Text {
    guard !str.isEmpty && !searched.isEmpty else { return Text(str) }

    var result: Text!
    let parts = str.components(separatedBy: searched)
    for i in parts.indices {
        result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
        if i != parts.count - 1 {
            result = result + Text(searched).bold()
        }
    }
    return result ?? Text(str)
}

func splitString(str:String,sep:String) -> [String]{
    let strlen:Int = str.count
    let seplen:Int = sep.count
    for i in 0..<strlen-seplen{
        var start=str.index(str.startIndex, offsetBy: i)
        let startIndex=str.index(str.startIndex,offsetBy: 0)
        let endIndex=str.index(startIndex,offsetBy: strlen-1)
        var end=str.index(startIndex, offsetBy: i+seplen-1)
        print(str[start...end].localizedCaseInsensitiveContains(sep))
        if(str[start...end].localizedCaseInsensitiveContains(sep)){
            var startF=str.index(start,offsetBy: -1)
            var endF=str.index(end,offsetBy: 1)
            return [String(str[startIndex...startF]),sep,String(str[endF...endIndex])]
        }
    }
    return [str]
}
