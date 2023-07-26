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
    let speechs: [String] = ["", "n", "v", "r", "s"]
    for part in parts {
        if part.contains(".") || speechs.contains(part) {
            result += 1
        } else {
            break
        }
    }
    return result
}

struct EnglishDefinition: View {
    var DictWord: DictStruct
    @Binding var clickedWord: DictStruct?
    var body: some View {
        let englishDefExists: Bool = DictWord.definition != ""
        if englishDefExists {
            Section(header: Text("english_definitions")) {
                let strTmp: String = DictWord.definition
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
                                    let text: String = parts[index]
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
                                    let text: String = parts[index]
                                        .trimmingCharacters(in: .whitespacesAndNewlines)
                                    if text != "" {
                                        let word: DictStruct = fetchDataFromWordName(word: text)
                                        Button {
                                            clickedWord = word
                                        } label: {
                                            Text(text)
                                        }
                                        .buttonStyle(ClickToChangeBackground())
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

struct ClickToChangeBackground: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // 设置前景色
            .foregroundColor(configuration.isPressed ? Color.white : Color.black)
//            .padding()
            .background(configuration.isPressed ? Color.blue : Color.clear)
            .cornerRadius(2)
    }
}
