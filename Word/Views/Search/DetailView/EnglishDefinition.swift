//
//  EnglishDefinition.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import SwiftUI
import WrappingHStack

struct EnglishDefinition: View {
    var DictWord: DictStruct
    @State var isShowWordSheet: Bool = false
    @State var clickedWord: DictStruct? = nil
    var body: some View {
        let englishDefExists: Bool = DictWord.definition != ""
        if englishDefExists {
            Section(header: Text("English Definitions")) {
                let meaningList: [String] = DictWord.definition.components(separatedBy: "\n")
                ForEach(0 ..< meaningList.count, id: \.self) { index in
                    let meaning: String = meaningList[index]
                    let parts: [String] = meaning.components(separatedBy: " ")

                    HStack {
                        Text(parts[0]) // 词性
                            .foregroundColor(Color(red: 192/255, green: 77/255, blue: 71/255)) // 应用对应的颜色
                            .italic()
                            .padding(.trailing, 4)
                        WrappingHStack(alignment: .leading) {
                            let dropText=parts.dropFirst()
                            ForEach(dropText.indices, id: \.self) { index in
                                let text = parts[index]
                                let word = fetchDataFromWordName(word: text)
                                Text(text).onTapGesture { clickedWord = word }
                            }
                        }
                    }
                }
                .sheet(item: $clickedWord) { word in
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            Text(word.name)
                                .font(.title)
                                .bold()
                                .padding([.leading, .top], 20)
                            if word.phonetic != "" {
                                Text("| "+word.phonetic+" |")
                                    .font(.system(size: 15))
                                    .padding(.leading, 10)
                                    .padding(.bottom, 5)
                            }
                            Spacer()
                        }
                        Divider()
                        List {
                            ImportanceRank(DictWord: word)
                            ChineseTranslations(DictWord: word)
                            EnglishDefinition(DictWord: word)
                            WordExchanges(isShowWordSheet: false, DictWord: word)
                        }
                    }
                }
            }
        }
    }
}
