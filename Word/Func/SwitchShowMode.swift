//
//  SwitchShowMode.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import Foundation

///判断显示方案和按钮文字
func switchShowMode(Language:inout String,showChineseOnly:inout Bool,showEnglishOnly:inout Bool){
    switch Language{
    case "隐藏中文":
        showChineseOnly=false
        showEnglishOnly=true
        Language="隐藏英文"
        break
    case "隐藏英文":
        showChineseOnly=true
        showEnglishOnly=false
        Language="中文英文"
        break
    case "中文英文":
        showChineseOnly=false
        showEnglishOnly=false
        Language="隐藏中文"
        break
    default:
        showChineseOnly=false
        showEnglishOnly=false
        Language="隐藏中文"
        break
    }
}
