//
//  EnglishDefinition.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import SwiftUI
import WrappingHStack

func getSeperateIndex(parts: [String]) -> Int {
    var result = 0
    for part in parts {
        if part.contains(".") || part == "" {
            result += 1
        } else {
            break
        }
    }
    return result
}

struct EnglishDefinition: View {
    var DictWord: DictStruct
//    @State var isShowWordSheet: Bool = false
    @Binding var clickedWord: DictStruct?
    var body: some View {
        let englishDefExists: Bool = DictWord.definition != ""
        if englishDefExists {
            Section(header: Text("English Definitions")) {
                let strTmp = DictWord.definition
                    .replacingOccurrences(of: "\n   ", with: " ")
                    .replacingOccurrences(of: "&", with: "")
                let meaningList: [String] = strTmp.components(separatedBy: "\n")
                ForEach(0 ..< meaningList.count, id: \.self) { index in
                    let parts: [String] = meaningList[index].components(separatedBy: " ")
                    let sep: Int = getSeperateIndex(parts: parts)
                    HStack {
                        VStack {
                            ForEach(parts.indices, id: \.self) { index in
                                if index < sep {
                                    let text = parts[index]
                                        .trimmingCharacters(in: .whitespacesAndNewlines)
                                    if text != "" {
                                        Text(parts[index]) // 词性
                                            .foregroundColor(Color(red: 192/255, green: 77/255, blue: 71/255))
                                            .italic()
                                            .padding(.trailing, 4)
                                    }
                                }
                            }
                        }
                        WrappingHStack(alignment: .leading) {
                            ForEach(parts.indices, id: \.self) { index in
                                if index >= sep {
                                    let text = parts[index]
                                        .trimmingCharacters(in: .whitespacesAndNewlines)
                                    if text != "" {
                                        let word = fetchDataFromWordName(word: text)
                                        Text(text).onTapGesture {
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
    }
}
