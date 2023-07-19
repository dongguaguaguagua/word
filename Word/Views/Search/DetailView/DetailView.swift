//
//  DetailView.swift
//  Word
//
//  Created by 胡宗禹 on 7/11/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var word: DictStruct
    var body: some View {
        let isInWordList: Bool = ModelData.word.map { $0.name }.contains(word.name)
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(word.name)
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
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
                }
            }
            VStack() {
                HStack() {
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
                        ModelData.word.append(singleWord(name: word.name, definition: "", date: getCurrentTime(timeFormat: .YYYYMMDDHHMMSS), tag: [], importance: 0))
                        saveData(data: ModelData.word)
                    } else {
                        ModelData.word.removeAll(where: { $0.name==word.name })
                        saveData(data: ModelData.word)
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

struct StarRatingView: View {
    var rating: Int

    var body: some View {
        HStack {
            Text("Collins ")
                .foregroundColor(Color.blue)
            Spacer()
            ForEach(1 ... 5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
// }
