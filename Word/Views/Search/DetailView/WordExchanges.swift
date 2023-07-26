//
//  WordExchanges.swift
//  Word
//
//  Created by 胡宗尧 on 7/21/23.
//

import SwiftUI

struct WordExchanges: View {
    var DictWord: DictStruct
    @Binding var clickedWord: DictStruct?
    var body: some View {
        let exchangeExists: Bool = DictWord.exchange != ""
        let trans: [String: String] = [
            "0": "base_form",
            "d": "past_tense",
            "p": "past_participle",
            "3": "3rd_person_singular_present",
            "i": "infinitive",
            "s": "plural",
            "r": "comparative",
            "t": "superlative",
            "1": "base_form_exchanges",
        ]
        if exchangeExists {
            Section(header: Text("word_exchanges")) {
                let changesList: [String] = DictWord.exchange.components(separatedBy: "/")
                ForEach(0 ..< changesList.count, id: \.self) { index in
                    let change: String = changesList[index]

                    if let translated = trans[String(change[change.startIndex])] {
                        HStack {
                            Text(LocalizedStringKey(translated))
                                .font(.system(size: 10))
                                .padding([.trailing, .leading, .top, .bottom], 3)
                                .foregroundColor(.blue)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .stroke(.blue, lineWidth: 1)
                                )

                            let startIndex = change.index(change.startIndex, offsetBy: 2) // 获取起始索引
                            let subString = String(change[startIndex ..< change.endIndex])
                            if translated == "base_form_exchanges" {
                                Text(changeString(s: subString))
                                    .italic()
                            } else {
                                let word = fetchDataFromWordName(word: subString)
                                HStack {
                                    Text(word.name)
                                        .lineLimit(1)
                                        .padding(.leading, 5)
                                    Spacer()
                                    Text(word.translation)
                                        .lineLimit(1)
                                        .foregroundColor(.gray)
                                }.onTapGesture {
                                    clickedWord = word
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

func changeString(s: String) -> String {
    let trans2: [String: String] = [
        "0": "do",
        "d": "did",
        "p": "done",
        "3": "does",
        "i": "doing",
        "s": "~s",
        "r": "~er",
        "t": "~est",
    ]
    var l: [String] = []
    s.forEach { char in
        if let translated2 = trans2[String(char)] {
            l.append(translated2)
        }
    }
    return l.joined(separator: ", ")
}
