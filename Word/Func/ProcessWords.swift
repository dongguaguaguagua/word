//
//  ProcessInput.swift
//  Word
//
//  Created by 胡宗禹 on 7/10/23.
//

import Foundation
import SwiftUI
import UIKit

func regexWord(str: String) -> String {
    let pattern = "[^a-zA-Z0-9]"

    do {
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: str.utf16.count)
        let modifiedString = regex.stringByReplacingMatches(in: str, options: [], range: range, withTemplate: "")

        return modifiedString
    } catch {
        print("Error: \(error)")
    }
    return str
}

// https://w3toppers.com/highlight-a-specific-part-of-the-text-in-swiftui
func hilightedText(str: String, searched: String) -> Text {
    guard !str.isEmpty && !searched.isEmpty else { return Text(str) }

    var result: Text!
//    let parts = str.components(separatedBy: searched)
    let parts = splitString(str: str, sep: searched)
    for i in parts {
        if i.caseInsensitiveCompare(searched) == .orderedSame {
            result = (result == nil ? Text(i).bold() : result + Text(i).bold())
        } else {
            result = (result == nil ? Text(i) : result + Text(i))
        }
    }
    return result ?? Text(str)
}

/// **CAUTION: This code is full of shit.
/// string instance is difficult to use**
/// Aimed to split strings into a string array that contains 1-3 strings
/// example:
/// `wiltshireite` and  `Tshire` will be splited into
/// `["wil", "Tshire", "ite"]` caseinsensitively.

func splitString(str: String, sep: String) -> [String] {
    /// The length of `str`
    let strlen: Int = str.count
    /// The length of `sep`
    let seplen: Int = sep.count
    /// The start index of `str`
    let startIndex = str.index(str.startIndex, offsetBy: 0)
    /// The end index of `str`
    let endIndex = str.index(startIndex, offsetBy: strlen-1)

    if strlen == seplen, str.localizedCaseInsensitiveContains(sep) {
        return [str]
    }
    if strlen < seplen {
        return []
    } else {
        /// `endNext`:Next position of `end`
        /// `startPrevious`:Previous position of `start`
        for i in 0...strlen-seplen {
            let start = str.index(str.startIndex, offsetBy: i)
            let end = str.index(startIndex, offsetBy: i + seplen-1)
            if str[start...end].localizedCaseInsensitiveContains(sep) {
                if i == 0 {
                    let endNext = str.index(end, offsetBy: 1)
                    return [String(str[startIndex...end]), String(str[endNext...endIndex])]
                } else if i == strlen-seplen {
                    let startPrevious = str.index(start, offsetBy: -1)
                    return [String(str[startIndex...startPrevious]), String(str[start...endIndex])]
                } else {
                    let startPrevious = str.index(start, offsetBy: -1)
                    let endNext = str.index(end, offsetBy: 1)
                    return [String(str[startIndex...startPrevious]), String(str[start...end]), String(str[endNext...endIndex])]
                }
            }
        }
    }
    return [str]
}

/// example:
/// `str`:               vicissitude
/// `searched`:    vi
/// output:            **vi**c**i**ss**i**tude
func fuzzyHighlightedText(str: String, searched: String) -> Text {
    guard !str.isEmpty && !searched.isEmpty else { return Text(str) }
    var result: Text!
    var i = str.startIndex
    while i != str.endIndex {
        if searched.localizedCaseInsensitiveContains(String(str[i])) {
            result = (result == nil ? Text(String(str[i])).bold() : result + Text(String(str[i])).bold())
        } else {
            result = (result == nil ? Text(String(str[i])) : result + Text(String(str[i])))
        }
        str.formIndex(after: &i)
    }
    return result ?? Text(str)
}
