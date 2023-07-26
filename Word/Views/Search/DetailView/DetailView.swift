//
//  DetailView.swift
//  Word
//
//  Created by 胡宗禹 on 7/11/23.
//

import SwiftUI
import WrappingHStack

struct WordView: View {
    @State var DictWord: DictStruct
    @State var clickedWord: DictStruct? = nil
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(DictWord.name)
                    .font(.title)
                    .bold()
                    .padding([.leading, .top], 20)
                if DictWord.phonetic != "" {
                    Text("| "+DictWord.phonetic+" |")
                        .font(.system(size: 15))
                        .padding(.leading, 10)
                        .padding(.bottom, 5)
                }
                Spacer()
            }
            Divider()
            List {
                ImportanceRank(DictWord: DictWord)
                ChineseTranslations(DictWord: DictWord)
                EnglishDefinition(DictWord: DictWord, clickedWord: $clickedWord)
                WordExchanges(DictWord: DictWord, clickedWord: $clickedWord)
            }
            .sheet(item: $clickedWord) { word in
                WordView(DictWord: word)
            }
        }
    }
}

struct DetailView: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var word: DictStruct
    var body: some View {
        let isInWordList: Bool = ModelData.word.map { $0.name }.contains(word.name)
        ZStack {
            WordView(DictWord: word)
            VStack {
                HStack {
                    Spacer()
                    if isInWordList {
                        RecordedSealView(dateText: getCurrentTime(timeFormat: .YYYYMMDDHHMMSS))
                            .padding(.trailing, 20)
                    }
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    if isInWordList==false {
                        let word=singleWord(name: word.name, definition: "", date: getCurrentTime(timeFormat: .YYYYMMDDHHMMSS), tag: [], importance: 0)
                        ModelData.word.append(word)
                        insertWordsInSql(word: word)
                    } else {
                        ModelData.word.removeAll(where: { $0.name==word.name })
                        let removeWordId=ModelData.word.filter({$0.name==word.name})
                        removeWordsInSql(uuid: Set(removeWordId.map{$0.id}))
                    }
                } label: {
                    Label("Add to word list", systemImage: isInWordList ? "star.fill" : "star")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .padding([.leading, .top, .trailing, .bottom], 0)
        .onAppear {
            if !ModelData.settings.recentSearchWord.contains(word.name) {
                ModelData.settings.recentSearchWord.append(word.name)
            }
        }
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
// }
