//
//  ChineseTranslations.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import SwiftUI

struct ChineseTranslations: View {
    var DictWord:DictStruct
    var body: some View {
        Section(header: Text("Chinese Translations")) {
            let meaningList: [String] = DictWord.translation.components(separatedBy: "\n")
            ForEach(0..<meaningList.count, id: \.self) { index in
                let meaning = meaningList[index]
                let parts = meaning.components(separatedBy: " ")

                HStack {
                    Text(parts[0]) // 词性
                        .foregroundColor(Color(red: 192/255, green: 77/255, blue: 71/255)) // 应用对应的颜色
                        .italic()
                    Text(parts.dropFirst().joined(separator: " "))
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}
