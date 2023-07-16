//
//  SwitchShowMode.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import Foundation

/// decide what text to show based on current situation
func switchShowMode(Language: inout String, showChineseOnly: inout Bool, showEnglishOnly: inout Bool) {
    switch Language {
    case "hide_native_language":
        showChineseOnly=false
        showEnglishOnly=true
        Language="hide_foreign_language"
    case "hide_foreign_language":
        showChineseOnly=true
        showEnglishOnly=false
        Language="show_all"
    case "show_all":
        showChineseOnly=false
        showEnglishOnly=false
        Language="hide_native_language"
    default:
        showChineseOnly=false
        showEnglishOnly=false
        Language="hide_native_language"
    }
}
